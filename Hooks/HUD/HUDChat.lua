HUDChat.line_height = 22

NepHook:Post(HUDChat, "init", function(self)
	self._panel:set_bottom(self._panel:parent():h() - 160)
	self._panel:set_w(600)	
	self._panel:child("output_panel"):set_w(600)
end)

function HUDChat:_create_input_panel()
	self._input_panel = self._panel:panel({
		name = "input_panel",
		h = 24,
		alpha = 0,
		x = 0,
		layer = 1,
		w = self._panel_width
	})

	self._input_panel:rect({
		name = "focus_indicator",
		layer = 0,
		visible = false,
		color = Color.white:with_alpha(0.2)
	})

	local say = self._input_panel:text({
		y = 0,
		name = "say",
		vertical = "center",
		hvertical = "center",
		align = "left",
		blend_mode = "normal",
		halign = "left",
		x = 0,
		layer = 1,
		text = utf8.to_upper(managers.localization:text("debug_chat_say")),
		font = "fonts/font_large_mf",
		font_size = tweak_data.menu.pd2_small_font_size,
		color = Color.white
	})
	local _, _, w, h = say:text_rect()

	say:set_size(w, self._input_panel:h())

	local input_text = self._input_panel:text({
		y = 0,
		name = "input_text",
		vertical = "center",
		wrap = true,
		align = "left",
		blend_mode = "normal",
		hvertical = "center",
		text = "",
		word_wrap = false,
		halign = "left",
		x = 0,
		layer = 1,
		font = "fonts/font_large_mf",
		font_size = tweak_data.menu.pd2_small_font_size,
		color = Color.white
	})
	local caret = self._input_panel:rect({
		name = "caret",
		h = 0,
		y = 0,
		w = 0,
		x = 0,
		layer = 2,
		color = Color(0.05, 1, 1, 1)
	})

	self._input_panel:gradient({
		blend_mode = "sub",
		name = "input_bg",
		valign = "grow",
		layer = -1,
		gradient_points = {
			0,
			Color.white,
			0.5,
			Color.white,
			1,
			Color.white:with_alpha(0)
		},
		h = self._input_panel:h()
    })
end

function HUDChat:_layout_output_panel()
	local output_panel = self._panel:child("output_panel")

	output_panel:set_w(self._output_width)

	local line_height = HUDChat.line_height
	local lines = 0

	for i = #self._lines, 1, -1 do
		local line = self._lines[i][1]
		local icon = self._lines[i][2]

		line:set_w(output_panel:w() - line:left())

		local _, _, w, h = line:text_rect()

		line:set_h(h)

		lines = lines + line:number_of_lines()
	end

	output_panel:set_h(line_height * math.min(10, lines))

	local y = 0

	for i = #self._lines, 1, -1 do
		local line = self._lines[i][1]
        local icon = self._lines[i][2]
        local avatar = self._lines[i][3]
		local _, _, w, h = line:text_rect()

		line:set_bottom(output_panel:h() - y)

		if icon then
			icon:set_top(line:top() + 1)
        end
        
        if avatar then
            avatar:set_top(line:top())
        end

		y = y + h
	end

	output_panel:set_bottom(self._input_panel:top())
end

function HUDChat:determinePeerId(color)
	if tostring(color) == "Color(1 * (1, 0.831373, 0))" then
		return -- System Message
	end

	local id = table.get_key(tweak_data.chat_colors, color)

	if not id then
		NepgearsyHUDReborn:Error("HUDChat:determinePeerId - No id found for this color. ID-Color = ", tostring(id), tostring(color))
		return
	end

    return id
end

function HUDChat:receive_message(name, message, color, icon)
    local peer_id = self:determinePeerId(color)
	local output_panel = self._panel:child("output_panel")
	local len = utf8.len(name) + 1
	local x = 0
    local icon_bitmap = nil

    local PeerAvatar = output_panel:bitmap({
        texture = "guis/textures/pd2/none_icon",
        h = 20,
        w = 20,
		visible = true,
		x = 1,
		y = 1
	})

	if peer_id then
		if managers.chat._player_steam_id[peer_id] then
			Steam:friend_avatar(1, managers.chat._player_steam_id[peer_id], function (texture)
				local avatar = texture or "guis/textures/pd2/none_icon"
				PeerAvatar:set_image(avatar)
			end)
			Steam:friend_avatar(1, managers.chat._player_steam_id[peer_id], function (texture)
				local avatar = texture or "guis/textures/pd2/none_icon"
				PeerAvatar:set_image(avatar)
			end)
		end
	else
		PeerAvatar:set_image("NepgearsyHUDReborn/HUD/SystemMessageIcon")
	end

	if icon then
		local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data(icon)
		icon_bitmap = output_panel:bitmap({
			y = 1,
			texture = icon_texture,
			texture_rect = icon_texture_rect,
            color = color,
            visible = false
        })
        icon_bitmap:set_left(PeerAvatar:right())
	end
	
	x = PeerAvatar:right() + 5

    local message_text = output_panel:text({
        halign = "left",
		vertical = "top",
		hvertical = "top",
		wrap = true,
		align = "left",
		blend_mode = "normal",
		word_wrap = true,
		y = 0,
		layer = 1,
		text = string.format("%s: %s", name, message),
		font = "fonts/font_large_mf",
		font_size = 22,
		x = x,
		color = color
    })

	local total_len = utf8.len(message_text:text())

	message_text:set_range_color(0, len, color)
	message_text:set_range_color(len, total_len, Color.white)

	local _, _, w, h = message_text:text_rect()

	message_text:set_h(h)
	table.insert(self._lines, {
		message_text,
        icon_bitmap,
        PeerAvatar
	})
	message_text:set_kern(message_text:kern())
	self:_layout_output_panel()

	if not self._focus then
		local output_panel = self._panel:child("output_panel")

		output_panel:stop()
		output_panel:animate(callback(self, self, "_animate_show_component"), output_panel:alpha())
		output_panel:animate(callback(self, self, "_animate_fade_output"))
	end
end