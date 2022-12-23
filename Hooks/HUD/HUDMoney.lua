HUDMoney = HUDMoney or class()

local Font = "fonts/font_pdth"
local FontTake = "fonts/font_eurostile_ext"

function HUDMoney:init(hud)
    self._hud_panel = hud.panel

    if self._hud_panel:child("money_panel") then
		self._hud_panel:remove(self._hud_panel:child("money_panel"))
    end

    self._hud_money_activated = NepgearsyHUDReborn:GetOption("ActivateMoneyHUD")

    self._money_panel = self._hud_panel:panel({
        name = "_money_panel",
        h = 32,
        w = 220,
        halign = "right",
        valign = "center",
        visible = self._hud_money_activated
    })

    local panel_position_base = managers.hud._hud_heist_timer._heist_timer_panel
    self._money_panel:set_top(panel_position_base:bottom() + 5)

    self._money_panel:bitmap({
        texture = "NepgearsyHUDReborn/HUD/AssaultBarReversed",
        w = self._money_panel:w(),
        h = self._money_panel:h(),
        layer = -1
    })

    self._money_panel_take = self._money_panel:text({
        text = utf8.to_upper("Take"),
        font = NepgearsyHUDReborn:SetFont(FontTake),
        color = Color.white,
        font_size = 16,
        x = 5,
        vertical = "center"
    })

    self._money_panel_take_amount = self._money_panel:text({
        text = "$ 0",
        font = NepgearsyHUDReborn:SetFont(Font),
        color = Color.white,
        font_size = 20,
        x = -5,
        vertical = "center",
        align = "right"
    })

    self._money_panel:rect({
        name = "debug",
        visible = false,
		halign = "grow",
		alpha = 0.25,
		layer = -1,
		valign = "grow",
		color = Color.red
    })

    self._previous_money_reached = 0
    BeardLib:AddUpdater("HUDMoneyUpdate", ClassClbk(self, "update"), false)
end

function HUDMoney:_show_blink(target)
	local TOTAL_T = 3
	local t = TOTAL_T

	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs(math.cos(t * 360 * 2)))

		target:set_alpha(alpha)
	end

	target:set_alpha(1)
end

function HUDMoney:update(t, dt)
    if not self._hud_money_activated then
        return
    end

    local money_manager = managers.money
    local civilian_money_reduction = money_manager:get_civilian_reduction()
    local mandatory_cash = money_manager:get_secured_mandatory_bags_money()
	local bonus_cash = money_manager:get_secured_bonus_bags_money()
	local instant_cash = managers.loot:get_real_total_small_loot_value()

    local total_cash = mandatory_cash + bonus_cash + instant_cash - civilian_money_reduction
    local str_cash = total_cash > 999 and money_manager:add_decimal_marks_to_string(tostring(total_cash)) or total_cash < -999 and money_manager:add_decimal_marks_to_string(tostring(total_cash)) or total_cash
    
    self._money_panel_take_amount:set_text("$ " .. str_cash)

    if total_cash < 0 then
        self._money_panel_take_amount:set_color(Color.red)
    else
        self._money_panel_take_amount:set_color(Color.white)
    end

    if total_cash ~= 0 and total_cash ~= self._previous_money_reached then
        self._money_panel_take_amount:stop()
        self._money_panel_take_amount:animate(ClassClbk(self, "_show_blink"))
        self._previous_money_reached = total_cash
    end
end