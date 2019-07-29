HUDStamina = HUDStamina or class()

function HUDStamina:init(hud)
    self._hud_panel = hud.panel

    if self._hud_panel:child("stamina_panel") then
		self._hud_panel:remove(self._hud_panel:child("stamina_panel"))
    end

    local stamina_enabled = NepgearsyHUDReborn:GetOption("ActivateStaminaBar")
    
    self._stamina_panel = self._hud_panel:panel({
        name = "stamina_panel",
        h = 256,
        w = 24,
        halign = "right",
        valign = "center",
        visible = stamina_enabled
    })

    self._stamina_panel:set_right(self._hud_panel:w())
    self._stamina_panel:set_center_y(self._hud_panel:center_y())

    self._stamina_text_panel = self._hud_panel:panel({
        name = "stamina_text_panel",
        w = 24,
        h = 18,
        visible = stamina_enabled
    })

    self._stamina_text_panel:rect({
        halign = "grow",
        valign = "grow",
        color = Color(0.5, 0, 0, 0),
        layer = -1
    })

    self._stamina_text_panel:set_bottom(self._stamina_panel:top())
    self._stamina_text_panel:set_left(self._stamina_panel:left())

    self._stamina_text = self._stamina_text_panel:text({
        font = "fonts/font_pdth",
        font_size = 14,
        color = Color.white,
        text = "?",
        align = "center",
        valign = "center",
        vertical = "center",
        layer = 1
    })

    self._stamina_icon_panel = self._hud_panel:panel({
        h = 24,
        w = 24,
        visible = stamina_enabled
    })

    self._stamina_icon_panel:set_top(self._stamina_panel:bottom())
    self._stamina_icon_panel:set_left(self._stamina_panel:left())

    self._stamina_icon_panel:bitmap({
        texture = "NepgearsyHUDReborn/HUD/StaminaIcon",
        w = 24,
        h = 24
    })
    
    self._stamina_border = self._stamina_panel:bitmap({
        texture = "NepgearsyHUDReborn/HUD/StaminaBorder",
        layer = 3,
        w = self._stamina_panel:w(),
        h = self._stamina_panel:h(),
        color = NepgearsyHUDReborn:GetOption("StaminaBarColor")
    })

    self._stamina_panel:bitmap({
        name = "stamina_bar",
        texture = "NepgearsyHUDReborn/HUD/StaminaFill",
        layer = 2,
        w = self._stamina_panel:w(),
        h = self._stamina_panel:h()
    })

    self._stamina_panel:bitmap({
        texture = "NepgearsyHUDReborn/HUD/StaminaBG",
        layer = 1,
        w = self._stamina_panel:w(),
        h = self._stamina_panel:h()
    })

    self._stamina_panel:rect({
        name = "debug",
        visible = false,
		halign = "grow",
		alpha = 0.25,
		layer = -1,
		valign = "grow",
		color = Color.red
    })

    self._curr_stamina = 0
	self._max_stamina = 0
end

function HUDStamina:set_stamina_value(value)
    self._curr_stamina = value

	self._stamina_panel:child("stamina_bar"):set_h(value / math.max(1, self._max_stamina) * self._stamina_panel:h())
    self._stamina_panel:child("stamina_bar"):set_bottom(self._stamina_panel:h())

    self._stamina_text:set_text(tostring(math.floor(value)))
    
    if self._curr_stamina < tweak_data.player.movement_state.stamina.MIN_STAMINA_THRESHOLD then
        self._stamina_panel:child("stamina_bar"):set_color(NepgearsyHUDReborn:GetOption("LowStaminaBarColor"))
        self._stamina_text:set_color(NepgearsyHUDReborn:GetOption("LowStaminaBarColor"))
    else
        self._stamina_panel:child("stamina_bar"):set_color(NepgearsyHUDReborn:GetOption("StaminaBarColor"))
        self._stamina_text:set_color(NepgearsyHUDReborn:GetOption("StaminaBarColor"))
    end

    self._stamina_border:set_color(NepgearsyHUDReborn:GetOption("StaminaBarColor"))
end

function HUDStamina:set_max_stamina(value)
	self._max_stamina = value
end