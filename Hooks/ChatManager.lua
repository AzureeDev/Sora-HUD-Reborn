NepHook:Post(ChatManager, "init", function(self)
	self._player_steam_id = {}
	self._player_steam_id[1] = "0"
	self._player_steam_id[2] = "0"
	self._player_steam_id[3] = "0"
	self._player_steam_id[4] = "0"
end)

function ChatManager:receive_message_by_peer(channel_id, peer, message)
	if self:is_peer_muted(peer) then
		return
	end

	local color_id = peer:id()
	local steam_id = peer:user_id()
	local color = tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
	self._player_steam_id[color_id] = steam_id

	self:_receive_message(channel_id, peer:name(), message, tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors], (peer:level() == nil and managers.experience:current_rank() > 0 or peer:rank() > 0) and "infamy_icon")
end

function ChatGui:receive_message(name, message, color, icon)
	if not alive(self._panel) or not managers.network:session() then
		return
	end

	local output_panel = self._panel:child("output_panel")
	local scroll_panel = output_panel:child("scroll_panel")
	local local_peer = managers.network:session():local_peer()
	local peers = managers.network:session():peers()
	local len = utf8.len(name) + 1
	local x = 0
	local icon_bitmap = nil

	if icon then
		local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data(icon)
		icon_bitmap = scroll_panel:bitmap({
			y = 1,
			texture = icon_texture,
			texture_rect = icon_texture_rect,
			color = color
		})
		x = icon_bitmap:right()
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
		layer = 0,
		text = name .. ": " .. message,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = x,
		w = scroll_panel:w() - x,
		color = color
	})
	local total_len = utf8.len(line:text())

	line:set_range_color(0, len, color)
	line:set_range_color(len, total_len, Color.white)

	local _, _, w, h = line:text_rect()

	line:set_h(h)

	local line_bg = scroll_panel:rect({
		hvertical = "top",
		halign = "left",
		layer = -1,
		color = Color.black:with_alpha(0.5)
	})

	line_bg:set_h(h)
	line:set_kern(line:kern())
	table.insert(self._lines, {
		line,
		line_bg,
		icon_bitmap
	})
	self:_layout_output_panel()

	if not self._focus then
		output_panel:stop()
		output_panel:animate(callback(self, self, "_animate_show_component"), output_panel:alpha())
		output_panel:animate(callback(self, self, "_animate_fade_output"))
		self:start_notify_new_message()
	end
end