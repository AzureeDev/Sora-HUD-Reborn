--[[
function LobbyCharacterData:init(panel, peer)
	self._parent = panel
	self._peer = peer
	self._panel = panel:panel({
		w = 256,
		h = 256
	})
    local peer_id = peer:id()
    local peer_user_id = peer:user_id()
    self._user_id = peer_user_id
	local color_id = peer_id
	local color = tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
	local name_text = self._panel:text({
		vertical = "top",
		name = "name",
		blend_mode = "add",
		align = "center",
		text = "",
		layer = 0,
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = color
	})

	name_text:set_text(peer:name() or "")

	local state_text = self._panel:text({
		vertical = "top",
		name = "state",
		blend_mode = "add",
		align = "center",
		text = "",
		layer = 0,
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = tweak_data.screen_colors.text
	})

	state_text:set_top(name_text:bottom())
	state_text:set_center_x(name_text:center_x())

	local texture = tweak_data.hud_icons:get_icon_data("infamy_icon")
	local infamy_icon = self._panel:bitmap({
		name = "infamy_icon",
		h = 32,
		w = 16,
		texture = texture,
		color = color
	})

	infamy_icon:set_right(name_text:x())
    infamy_icon:set_top(name_text:y())
    
    local player_avatar = self._panel:bitmap({
        name = "peer_avatar",
        h = 128,
        w = 128,
        texture = "guis/textures/pd2/none_icon"
    })

    log("gogogo")
    player_avatar:set_bottom(name_text:top())
    player_avatar:set_left(name_text:left())

	self._name_text = name_text
	self._state_text = state_text
    self._infamy_icon = infamy_icon
    self._player_avatar = player_avatar

	local level = managers.crime_spree:get_peer_spree_level(peer:id())
	local level_text = level >= 0 and managers.localization:text("menu_cs_level", {
		level = managers.experience:cash_string(level, "")
	}) or ""
	local spree_text = self._panel:text({
		vertical = "top",
		name = "spree_level",
		blend_mode = "add",
		align = "center",
		text = "",
		layer = 0,
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = tweak_data.screen_colors.crime_spree_risk
	})
	self._spree_text = spree_text

	self:update_character()

	if Global.game_settings.single_player then
		self._panel:set_visible(false)
	end
end

function LobbyCharacterData:update_character()
	if not self:_can_update() then
		return
	end

	local peer = self._peer
	local local_peer = managers.network:session() and managers.network:session():local_peer()
	local name_text = peer:name()
	local show_infamy = false
	local player_level = peer == local_peer and managers.experience:current_level() or peer:level()
	local player_rank = peer == local_peer and managers.experience:current_rank() or peer:rank()

	if player_level then
		local experience = (player_rank > 0 and managers.experience:rank_string(player_rank) .. "-" or "") .. player_level
		name_text = name_text .. " (" .. experience .. ")"
	end

    show_infamy = player_rank > 0
    
    Steam:friend_avatar(1, tostring(self._user_id), function (texture)
        self._player_avatar:set_image(texture or "guis/textures/pd2/none_icon")
    end)

	self._name_text:set_text(name_text)
	self._infamy_icon:set_visible(show_infamy)

	if managers.crime_spree:is_active() then
		local level = managers.crime_spree:get_peer_spree_level(peer:id())

		if level >= 0 then
			local level_text = managers.localization:text("menu_cs_level", {
				level = managers.experience:cash_string(level, "")
			})

			self._spree_text:set_text(level_text)
		else
			self._spree_text:set_text("")
		end
	else
		self._spree_text:set_text("")
	end

	self:update_character_menu_state(nil)
	self:sort_text_and_reposition()
end

function LobbyCharacterData:sort_text_and_reposition()
	local order = {
		self._name_text,
		self._state_text
	}

	if managers.crime_spree:is_active() then
		table.insert(order, 1, self._spree_text)
	end

	local max_w = 0

	for i, text in ipairs(order) do
		local _, _, w = self:make_fine_text(text)
		max_w = math.max(max_w, w)

		if i > 1 then
			text:set_top(order[i - 1]:bottom())
		else
			text:set_top(0)
		end
	end

	local extra_padding = 16

	self._panel:set_w(max_w + extra_padding * 2)

	for i, text in ipairs(order) do
		text:set_center_x(self._panel:w() * 0.5)
	end

	self._infamy_icon:set_right(self._name_text:x())
    self._infamy_icon:set_top(self._name_text:y())
    self._player_avatar:set_top(self._panel:top())
    self._player_avatar:set_left(self._name_text:left())
	self:update_position()
end
--]]