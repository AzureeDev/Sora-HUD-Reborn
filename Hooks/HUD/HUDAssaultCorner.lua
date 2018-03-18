NepHook:Post(HUDAssaultCorner, "init", function(self)
    local assault_panel = self._hud_panel:child("assault_panel")
    local hostages_panel = self._hud_panel:child("hostages_panel")
    self._hostages_bg_box:set_visible(false)
    self._hud_panel:child("casing_panel"):set_visible(false)
    hostages_panel:set_visible(false)
    self._bg_box:set_visible(false)
    assault_panel:set_visible(false)
    local icon_assaultbox = assault_panel:child("icon_assaultbox")
    icon_assaultbox:set_visible(false)
    self._bg_box:set_visible(false)
    assault_panel:set_visible(false)
    
    ------------------------------------------
    ------------------------------------------

    self._heartbeat = false

    local assault_panel_v2 = self._hud_panel:panel({
        name = "assault_panel_v2",
        w = 356,
        h = 40
    })

    local thund_panel = self._hud_panel:panel({
        w = 64,
        h = 128
    })

    self._assault_panel_v2 = assault_panel_v2

    assault_panel_v2:set_top(0)
    assault_panel_v2:set_right(self._hud_panel:w())
    
    thund_panel:set_top(assault_panel_v2:bottom())
    thund_panel:set_right(assault_panel_v2:right())

    self._assault_banner = assault_panel_v2:panel({
        w = 356,
        h = 40,
        visible = true
    })

    assault_panel_v2:panel({
		name = "text_panel",
		layer = 1
	})
    
    local assaultBanner = self._assault_banner:bitmap({
        name = "assaultBanner",
        texture = "NepgearsyHUDReborn/HUD/AssaultBar",
        w = 356,
        h = 40,
        color = Color.white,
        visible = true
    })

    local Thund = thund_panel:bitmap({
        name = "Thund",
        texture = "NepgearsyHUDReborn/HUD/Thund",
        w = 64,
        h = 128,
        color = Color.white
    })
    self.Thund = Thund

    local textAssaultBanner = self._assault_banner:text({
        name = "textAssaultBanner",
        text = "",
        font = "fonts/font_large_mf",
        font_size = 28,
        vertical = "center",
        align = "right",
        x = -10,
        color = Color.black,
        layer = 2
    })

    local function animate_heartbeat(o)
        while self._heartbeat do
            over(1, function (p)
                o:set_alpha(math.lerp(0.2, 1, math.sin(p * 180)))
            end)
        end
    end

    if managers.groupai:state():whisper_mode() then
        self._current_assault_color = Color.white
        self:_set_text_list(self:_get_stealth_textlist())
        local box_text_panel = self._assault_panel_v2:child("text_panel")
        box_text_panel:stop()
        box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"), 35)
        box_text_panel:animate(ClassClbk(self, "_show_blink"))
    end
end)

function HUDAssaultCorner:SetHeartbeat(status)
    self._heartbeat = status
end

function HUDAssaultCorner:SetAssaultText(text)
    self._assault_banner:child("textAssaultBanner"):set_text(managers.localization:to_upper_text(text))
end

function HUDAssaultCorner:_update_assault_hud_color(color)
    self._current_assault_color = color
    
    local assaultBanner = self._assault_banner:child("assaultBanner")
    assaultBanner:set_color(color)
    self.Thund:set_color(color)
end

function HUDAssaultCorner:show_casing(mode)
	return
end

function HUDAssaultCorner:_start_assault(text_list)
	text_list = text_list or {""}
	local assault_panel = self._hud_panel:child("assault_panel_v2")
	local text_panel = assault_panel:child("text_panel")

	self:_set_text_list(text_list)

	self._assault = true

	if self._assault_panel_v2:child("text_panel") then
		self._assault_panel_v2:child("text_panel"):stop()
		self._assault_panel_v2:child("text_panel"):clear()
	else
		self._assault_panel_v2:panel({name = "text_panel"})
	end

	local config = {
		attention_forever = true,
		attention_color = self._assault_color,
		attention_color_function = callback(self, self, "assault_attention_color_function")
	}

	local box_text_panel = self._assault_panel_v2:child("text_panel")
	box_text_panel:stop()
    box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"))
    box_text_panel:animate(ClassClbk(self, "_show_blink"))
	self:_set_feedback_color(self._assault_color)

	if alive(self._wave_bg_box) then
		self._wave_bg_box:stop()
		self._wave_bg_box:animate(callback(self, self, "_animate_wave_started"), self)
	end
end

function HUDAssaultCorner:_end_assault()
	if not self._assault then
		self._start_assault_after_hostage_offset = nil

		return
	end

	self:_set_feedback_color(nil)

	self._assault = false
	local box_text_panel = self._assault_panel_v2:child("text_panel")

    box_text_panel:animate(ClassClbk(self, "_hide_blink"))

	self._remove_hostage_offset = true
	self._start_assault_after_hostage_offset = nil

	if self:is_safehouse_raid() then
		self:_update_assault_hud_color(self._assault_survived_color)
		self:_set_text_list(self:_get_survived_assault_strings())
		box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"))
		icon_assaultbox:stop()
		icon_assaultbox:animate(callback(self, self, "_show_icon_assaultbox"))
		self._wave_bg_box:stop()
		self._wave_bg_box:animate(callback(self, self, "_animate_wave_completed"), self)
	else
		self:_close_assault_box()
	end
end

function HUDAssaultCorner:_set_text_list(text_list)
	local assault_panel = self._hud_panel:child("assault_panel_v2")
	local text_panel = assault_panel:child("text_panel")
	text_panel:script().text_list = text_panel:script().text_list or {}

	while #text_panel:script().text_list > 0 do
		table.remove(text_panel:script().text_list)
	end

	self._assault_banner:script().text_list = self._assault_banner:script().text_list or {}

	while #self._assault_banner:script().text_list > 0 do
		table.remove(self._assault_banner:script().text_list)
	end

	for _, text_id in ipairs(text_list) do
		table.insert(text_panel:script().text_list, text_id)
		table.insert(self._assault_banner:script().text_list, text_id)
	end
end

function HUDAssaultCorner:_animate_text(text_panel, bg_box, color, color_function, speed_text)
	local text_list = (bg_box or self._assault_banner):script().text_list
	local text_index = 0
	local texts = {}
	local padding = 10


	-- Lines: 209 to 240
	local function create_new_text(text_panel, text_list, text_index, texts)
		if texts[text_index] and texts[text_index].text then
			text_panel:remove(texts[text_index].text)

			texts[text_index] = nil
		end

		local text_id = text_list[text_index]
		local text_string = ""

		if type(text_id) == "string" then
			text_string = managers.localization:to_upper_text(text_id)
		elseif text_id == Idstring("risk") then
			local use_stars = true

			if managers.crime_spree:is_active() then
				text_string = text_string .. managers.localization:to_upper_text("menu_cs_level", {level = managers.experience:cash_string(managers.crime_spree:server_spree_level(), "")})
				use_stars = false
			end

			if use_stars then
				for i = 1, managers.job:current_difficulty_stars(), 1 do
					text_string = text_string .. managers.localization:get_default_macro("BTN_SKULL")
				end
			end
		end

		local mod_color = color_function and color_function() or color or self._assault_color
		local text = text_panel:text({
			vertical = "center",
			h = 10,
			w = 10,
			align = "center",
			blend_mode = "add",
			layer = 1,
			text = text_string,
			color = Color.black,
			font_size = tweak_data.hud_corner.assault_size,
			font = tweak_data.hud_corner.assault_font
		})
		local _, _, w, h = text:text_rect()

		text:set_size(w, h)

		texts[text_index] = {
			x = text_panel:w() + w * 0.5 + padding * 2,
			text = text
		}
	end

	while true do
		local dt = coroutine.yield()
		local last_text = texts[text_index]

		if last_text and last_text.text then
			if last_text.x + last_text.text:w() * 0.5 + padding < text_panel:w() then
				text_index = text_index % #text_list + 1

				create_new_text(text_panel, text_list, text_index, texts)
			end
		else
			text_index = text_index % #text_list + 1

			create_new_text(text_panel, text_list, text_index, texts)
		end

		local speed = speed_text or 90

		for i, data in pairs(texts) do
			if data.text then
				data.x = data.x - dt * speed

				data.text:set_center_x(data.x)
				data.text:set_center_y(text_panel:h() * 0.5)

				if data.x + data.text:w() * 0.5 < 0 then
					text_panel:remove(data.text)

					data.text = nil
				elseif color_function then
					data.text:set_color(color_function())
				end
			end
		end
	end
end

function HUDAssaultCorner:_show_icon_assaultbox(icon_assaultbox)
end

function HUDAssaultCorner:_hide_icon_assaultbox(icon_assaultbox)
end

-- Lines: 552 to 577
function HUDAssaultCorner:_hide_blink(target)
	local TOTAL_T = 2
	local t = TOTAL_T

	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs(math.cos(t * 360 * 2)))

		target:set_alpha(alpha)
	end

	target:set_alpha(0)
	target:stop()
    target:clear()
    target:set_alpha(1)
end

function HUDAssaultCorner:_show_blink(target)
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

function HUDAssaultCorner:_get_stealth_textlist()
    if managers.job:current_difficulty_stars() > 0 then
        local ids_risk = Idstring("risk")

        return {
            "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
            "hud_assault_end_line",
            ids_risk,
            "hud_assault_end_line",
            "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
            "hud_assault_end_line",
            ids_risk,
            "hud_assault_end_line"
        }
    else
        return {
            "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
            "hud_assault_end_line",
            "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
            "hud_assault_end_line",
            "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
            "hud_assault_end_line"
        }
    end
end

function HUDAssaultCorner:_get_incoming_textlist()
    if managers.job:current_difficulty_stars() > 0 then
        local ids_risk = Idstring("risk")

        return {
            "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
            "hud_assault_end_line",
            ids_risk,
            "hud_assault_end_line",
            "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
            "hud_assault_end_line",
            ids_risk,
            "hud_assault_end_line"
        }
    else
        return {
            "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
            "hud_assault_end_line",
            "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
            "hud_assault_end_line",
            "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
            "hud_assault_end_line"
        }
    end
end
