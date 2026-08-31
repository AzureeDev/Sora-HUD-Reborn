if NepgearsyHUDReborn:GetOption("EnableSteamAvatarsInChat") then
	HUDChat.line_height = 22

	NepHook:Post(HUDChat, "init", function(self)
		self._panel:set_bottom(self._panel:parent():h() - 160)
	end)

	NepHook:Post(HUDChat, "_layout_output_panel", function(self)
		local y = 0
		for i = #self._lines, 1, -1 do
			local line = self._lines[i][1]
			local icon = self._lines[i][2]
			local avatar = self._lines[i][3]

			line:set_bottom(self._panel:child("output_panel"):child("scroll_panel"):h() - y)

			if icon then
				icon:set_left(icon:left())
				icon:set_top(line:top() + 1)
				line:set_left(icon:right())
			else
				line:set_left(line:left())
			end

			if avatar then
				avatar:set_top(line:top())
			end

			y = y + HUDChat.line_height * line:number_of_lines()
		end
	end)

	NepHook:Post(HUDChat, "_create_input_panel", function(self)
		self._input_panel:child("say"):set_font(Idstring("fonts/font_large_mf"))
		self._input_panel:child("say"):set_font_size(20)
		self._input_panel:child("input_text"):set_font(Idstring("fonts/font_large_mf"))
		self._input_panel:child("input_text"):set_font_size(20)
	end)

	local id_color = function(color)
		if tostring(color) == "Color(1 * (1, 0.831373, 0))" then
			return -- System Message
		end

		local id = table.get_key(tweak_data.chat_colors, color)
		if not id then
			NepgearsyHUDReborn:Error("HUDChat:id_color - id returned nil for color: " .. tostring(color))
			return
		end

		return id
	end

	function HUDChat:receive_message(name, message, color, icon)
		local output_panel = self._panel:child("output_panel")
		local scroll_panel = output_panel:child("scroll_panel")
		local len = utf8.len(name) + 1
		local x = 0
		local icon_bitmap = nil

		local avatar = scroll_panel:bitmap({
			texture = "guis/textures/pd2/none_icon",
			h = 20,
			w = 20,
			visible = true,
			x = 1,
			y = 1
		})

		if icon then
			local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data(icon)
			icon_bitmap = scroll_panel:bitmap({
				y = 1,
				texture = icon_texture,
				texture_rect = icon_texture_rect,
				color = color
			})
			icon_bitmap:set_left(avatar:right())
		end
		x = avatar:right() + (icon and 15 or 3)

		local peer_id = id_color(color)
		if peer_id then
			if managers.chat._player_steam_id[peer_id] then
				NepgearsyHUDReborn:SteamAvatar(managers.chat._player_steam_id[peer_id], function(texture)
					if texture then
						avatar:set_image(texture)
					end
				end)
			end
		else
			x = avatar:right() + 3
			avatar:set_image("NepgearsyHUDReborn/HUD/SystemMessageIcon")
		end

		local line = scroll_panel:text({
			halign = "left",
			vertical = "top",
			hvertical = "top",
			wrap = true,
			align = "left",
			blend_mode = "normal",
			word_wrap = true,
			y = 0,
			layer = 1,
			text = name .. ": " .. message,
			font = "fonts/font_large_mf",
			font_size = 20,
			x = x,
			color = color
		})
		local total_len = utf8.len(line:text())

		line:set_range_color(0, len, color)
		line:set_range_color(len, total_len, Color.white)

		local _, _, w, h = line:text_rect()

		line:set_h(h)
		table.insert(self._lines, {
			line,
			icon_bitmap,
			avatar
		})
		line:set_kern(line:kern())
		self:_layout_output_panel()

		if not self._focus then
			scroll_panel:set_bottom(output_panel:h())
			self:set_scroll_indicators()

			output_panel:stop()
			output_panel:animate(callback(self, self, "_animate_show_component"), output_panel:alpha())
			output_panel:animate(callback(self, self, "_animate_fade_output"))
		end
	end
end