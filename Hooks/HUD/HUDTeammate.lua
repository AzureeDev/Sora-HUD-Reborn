function HUDTeammate:init(i, teammates_panel, is_player, width)
    self._id = i
	local small_gap = 8
	local gap = 0
    local pad = 4
    self._is_ai = self._ai
	local main_player = true
    self._main_player = main_player
	local names = {
		"WWWWWWWWWWWWQWWW",
		"AI Teammate",
		"FutureCatCar",
		"WWWWWWWWWWWWQWWW"
	}
	local teammate_panel = teammates_panel:panel({
		halign = "right",
		visible = false,
        x = 64,
        h = 120,
		name = "" .. i,
		w = math.round(width) - 64
	})
    self._panel = teammate_panel

    local subpanel_bg = self._panel:bitmap({
        name = "subpanel_bg",
        color = Color.green,
        layer = -1,
        texture = "NepgearsyHUDReborn/HUD/Teammate",
        w = 309,
        h = 90,
        y = 30
    })

	if not main_player then
		teammate_panel:set_h(84)
		teammate_panel:set_bottom(teammates_panel:h())
		teammate_panel:set_halign("left")
	end

	self._player_panel = teammate_panel:panel({name = "player"})
	self._health_data = {
		current = 0,
		total = 0
	}
	self._armor_data = {
		current = 0,
		total = 0
	}
	local name = teammate_panel:text({
		name = "name",
		vertical = "center",
		y = 0,
		layer = 1,
		text = "" .. names[i],
		color = Color.white,
		font_size = tweak_data.hud_players.name_size,
		font = "fonts/font_large_mf"
	})
	local _, _, name_w, _ = name:text_rect()

	managers.hud:make_fine_text(name)
	name:set_leftbottom(name:h(), teammate_panel:h() - 70)

	if not main_player then
		name:set_x(48 + name:h() + 4)
		name:set_bottom(teammate_panel:h() - 30)
	end

	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = {
		84,
		0,
		44,
		32
	}
	local cs_rect = {
		84,
		34,
		19,
		19
	}
	local csbg_rect = {
		105,
		34,
		19,
		19
	}
	local bg_color = Color.white / 3

	teammate_panel:bitmap({
		name = "name_bg",
		visible = true,
		layer = 0,
		texture = tabs_texture,
		texture_rect = bg_rect,
		color = bg_color,
		x = name:x(),
		y = name:y() - 1,
		w = name_w + 4,
		h = name:h()
	})
	teammate_panel:bitmap({
		name = "callsign_bg",
		layer = 0,
		blend_mode = "normal",
		texture = tabs_texture,
		texture_rect = csbg_rect,
		color = bg_color,
		x = name:x() - name:h(),
		y = name:y() + 1,
		w = name:h() - 2,
		h = name:h() - 2
	})
	teammate_panel:bitmap({
		name = "callsign",
		layer = 1,
		blend_mode = "normal",
		texture = tabs_texture,
		texture_rect = cs_rect,
		color = (tweak_data.chat_colors[i] or tweak_data.chat_colors[#tweak_data.chat_colors]):with_alpha(1),
		x = name:x() - name:h(),
		y = name:y() + 1,
		w = name:h() - 2,
		h = name:h() - 2
	})

	local box_ai_bg = teammate_panel:bitmap({
		texture = "guis/textures/pd2/box_ai_bg",
		name = "box_ai_bg",
		alpha = 0,
		visible = false,
		y = 0,
		color = Color.white,
		w = teammate_panel:w()
	})

	box_ai_bg:set_bottom(name:top())

	local box_bg = teammate_panel:bitmap({
		texture = "guis/textures/pd2/box_bg",
		name = "box_bg",
		y = 0,
		visible = false,
		color = Color.white,
		w = teammate_panel:w()
	})

	box_bg:set_bottom(name:top())

	local texture, rect = tweak_data.hud_icons:get_icon_data("pd2_mask_" .. i)
	local size = 64
	local mask_pad = 2
	local mask_pad_x = 3
	local y = (teammate_panel:h() - name:h()) - size + mask_pad
	local mask = teammate_panel:bitmap({
		name = "mask",
		visible = false,
		layer = 1,
		color = Color.white,
		texture = texture,
		texture_rect = rect,
		x = -mask_pad_x,
		w = size,
		h = size,
		y = y
	})
	local radial_size = main_player and 64 or 48
	local radial_health_panel = self._player_panel:panel({
		name = "radial_health_panel",
		x = 5,
		layer = 1,
		w = radial_size + 4,
		h = radial_size + 4,
		y = mask:y()
	})

    radial_health_panel:set_bottom(self._panel:h() - 11)
    
    self._radial_health_panel = radial_health_panel
	self:_create_radial_health(radial_health_panel, main_player)

	local weapon_panel_w = 80
	local weapons_panel = self._player_panel:panel({
		name = "weapons_panel",
		visible = true,
		layer = 0,
		w = weapon_panel_w,
		h = radial_health_panel:h(),
		x = radial_health_panel:right() + 4,
		y = radial_health_panel:y()
	})
    self._weapons_panel = weapons_panel
	self:_create_weapon_panels(weapons_panel)
	self:_create_equipment_panels(self._panel, weapons_panel:right(), weapons_panel:top(), weapons_panel:bottom())

	local bag_w = 32
	local bag_h = 31
	local carry_panel = self._player_panel:panel({
		name = "carry_panel",
		visible = false,
		x = 0,
		layer = 1,
		w = bag_w,
		h = bag_h + 2,
		y = radial_health_panel:top() - bag_h
	})

	self:_create_carry(carry_panel)

	local interact_panel = self._player_panel:panel({
		layer = 3,
		name = "interact_panel",
		visible = false
	})

	interact_panel:set_shape(weapons_panel:shape())
	interact_panel:set_shape(radial_health_panel:shape())
	interact_panel:set_size(radial_size * 1.25, radial_size * 1.25)
	interact_panel:set_center(radial_health_panel:center())

	local radius = interact_panel:h() / 2 - 4
	self._interact = CircleBitmapGuiObject:new(interact_panel, {
		blend_mode = "add",
		use_bg = true,
		rotation = 360,
		layer = 0,
		radius = radius,
		color = Color.white
	})

	self._interact:set_position(4, 4)
	self._special_equipment = {}
    self:create_waiting_panel(teammates_panel)
    
    local panel_bg = self._panel:rect({
        name = "panel_bg",
        color = Color.black,
        alpha = 0.4,
        layer = -1,
        halign = "scale",
        valign = "scale",
        visible = false
    })

    self.teammates = teammates_panel
    self._panel:set_h(120)
    self._panel:set_w(270)
    self._panel:set_bottom(teammates_panel:h())

    self.BGAvatar = self._panel:rect({
        name = "BGAvatar",
        color = Color.black,
        layer = 0,
        h = 64,
        w = 64
    })

    self.Avatar = self._panel:bitmap({
        texture = "guis/textures/pd2/none_icon",
        h = 60,
        w = 60,
        layer = 1
    })
    self.BGAvatar:set_bottom(self._radial_health_panel:bottom() - 2)
    self.Avatar:set_bottom(self.BGAvatar:bottom() - 2)
    self.Avatar:set_left(self.BGAvatar:left() + 2)

    if self._main_player then
        self._steam_id = self:GetSteamIDByPeer()
        self:SetupAvatar()
    end

    self._panel:child("name_bg"):set_visible(false)
	self._panel:child("callsign_bg"):set_visible(false)
    self._panel:child("callsign"):set_visible(false)
    
    self:ApplyNepgearsyHUD()
end

NepHook:Post(HUDTeammate, "_create_radial_health", function (self, radial_health_panel)
    local radial_bg = radial_health_panel:child("radial_bg")
    local radial_health = radial_health_panel:child("radial_health")
    local radial_shield = radial_health_panel:child("radial_shield")
    local damage_indicator = radial_health_panel:child("damage_indicator")

    local function set_texture(o, texture) --set using the texture's actual size not a hardcoded size like 64/128.
        local w,h = o:texture_width(), o:texture_height()
        o:set_image(texture, w, 0, -w, h)
    end

    set_texture(radial_bg, "NepgearsyHUDReborn/HUD/HealthBG")
    set_texture(radial_health, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("HealthColor"), "Health"))
    set_texture(radial_shield, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("ShieldColor"), "Armor"))
    damage_indicator:hide() -- Thats a buggy mess anyways
end)

function HUDTeammate:GetSteamIDByPeer()
    local peer = self:peer_id() or managers.network:session():local_peer():id()
    log("PEER / LOCAL_PEER ", tostring(self:peer_id()), tostring(managers.network:session():local_peer():id()))
    local steam_id = managers.network:session():peer(peer):user_id()

    return tostring(steam_id)
end

function HUDTeammate:SetupBotAvatar()
    self.Avatar:set_image("NepgearsyHUDReborn/HUD/AI")
end

function HUDTeammate:SetupAvatar()
    log("STEAM ID IS ", self._steam_id)
    Steam:friend_avatar(Steam.LARGE_AVATAR, self._steam_id, function(texture)
        self.Avatar:animate(function()
            Steam:friend_avatar(Steam.LARGE_AVATAR, self._steam_id, function(texture)
                self.Avatar:set_image(texture or "guis/textures/pd2/none_icon")
                self.Avatar:set_visible(true)
                self.BGAvatar:set_visible(true)
            end)
        end)
    end)
end

function HUDTeammate:set_state(state)
	local teammate_panel = self._panel
    local is_player = state == "player"
    local name = teammate_panel:child("name")
    
    if is_player then
        teammate_panel:set_h(120)
        teammate_panel:child("subpanel_bg"):set_h(90)
        teammate_panel:set_bottom(self.teammates:h())
        name:set_left(self.Avatar:left())
        name:set_top(teammate_panel:top() + 8)
        self._panel:set_visible(true)    
        self._steam_id = self:GetSteamIDByPeer()
        self:SetupAvatar()
    else
        teammate_panel:set_h(35)
        teammate_panel:child("subpanel_bg"):set_h(35)
        teammate_panel:set_bottom(self.teammates:h())
        name:set_bottom(teammate_panel:h() - 8)
        self.Avatar:set_visible(false)
        self.BGAvatar:set_visible(false)
    end
end

NepHook:Post(HUDTeammate, "remove_panel", function(self, weapons_panel)
    self._is_ai = nil
end)

function HUDTeammate:ApplyNepgearsyHUD()
    local name = self._panel:child("name")
    local name_bg = self._panel:child("name_bg")
    local callsign_bg = self._panel:child("callsign_bg")
    local callsign = self._panel:child("callsign")
    
    name:set_left(self.Avatar:left())
    name:set_top(self._panel:top() + 8)

    self._player_panel:set_w(309)

    self._radial_health_panel:set_x(self._radial_health_panel:x() + 64)
    self._weapons_panel:set_x(self._radial_health_panel:right() + 2)
    self._deployable_equipment_panel:set_x(self._weapons_panel:right() + 2)
    self._cable_ties_panel:set_x(self._weapons_panel:right() + 2)
    self._grenades_panel:set_x(self._weapons_panel:right() + 2)
end

function HUDTeammate:set_callsign(id)
	local name = self._panel:child("name")
	name:set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]))
    self._panel:child("subpanel_bg"):set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]))
    self.BGAvatar:set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]))
end

NepHook:Post(HUDTeammate, "set_name", function(self, teammate_name)
    local teammate_panel = self._panel
    local name = teammate_panel:child("name")
    
    name:set_text(teammate_name)
    local h = name:h()
	managers.hud:make_fine_text(name)
	name:set_h(h)
end)