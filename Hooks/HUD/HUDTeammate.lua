NepHook:Post(HUDTeammate, "init", function(self, i, teammates_panel, is_player, width)
    local MyPanel = i == HUDManager.PLAYER_PANEL
	local name = self._panel:child("name")
	
	name:configure({
		vertical = "center",
		layer = 1,
		font = "fonts/font_eurostile_ext",
		font_size = tweak_data.hud_players.name_size - 2
	})
    managers.hud:make_fine_text(name)

	local subpanel_bg = self._panel:bitmap({
        name = "subpanel_bg",
        color = Color.green,
        layer = -1,
        texture = "NepgearsyHUDReborn/HUD/Teammate",
        w = 309,
        h = 90,
        y = 30
	})

	self._radial_health_panel = self._player_panel:child("radial_health_panel")
	self._radial_health_panel:set_bottom(self._panel:h() - 11)

	local HealthNumber = self._radial_health_panel:text({
		name = "HealthNumber",
		font = "fonts/font_large_mf",
		font_size = 16,
		text = "",
		align = "center",
		vertical = "center"
	})
    self.HealthNumber = HealthNumber

	self._weapons_panel = self._player_panel:child("weapons_panel")

    self.teammates = teammates_panel
    self._panel:set_h(120)
    self._panel:set_w(270)
    self._panel:set_bottom(teammates_panel:h())

    self.BGAvatar = self._panel:rect({
        name = "BGAvatar",
        color = Color.black,
        layer = 0,
        h = 64,
		w = 64,
		x = 2
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

	if MyPanel then
		self._steam_id = self:GetSteamIDByPeer()
		self:SetupAvatar()
	end
	
    self._panel:child("name_bg"):set_visible(false)
	self._panel:child("callsign_bg"):set_visible(false)
    self._panel:child("callsign"):set_visible(false)
    
    self:ApplyNepgearsyHUD()
end)

NepHook:Post(HUDTeammate, "_create_radial_health", function (self, radial_health_panel)
    local radial_bg = radial_health_panel:child("radial_bg")
    local radial_health = radial_health_panel:child("radial_health")
    local radial_shield = radial_health_panel:child("radial_shield")
    local damage_indicator = radial_health_panel:child("damage_indicator")
    local radial_custom = radial_health_panel:child("radial_custom")
    local radial_ability_meter = radial_health_panel:child("radial_ability"):child("ability_meter")
    local ability_icon = radial_health_panel:child("radial_ability"):child("ability_icon")
    local radial_absorb_shield_active = radial_health_panel:child("radial_absorb_shield_active")
    local radial_absorb_health_active = radial_health_panel:child("radial_absorb_health_active")
    local radial_info_meter = radial_health_panel:child("radial_info_meter")
    local radial_info_meter_bg = radial_health_panel:child("radial_info_meter_bg")
    

    local function set_texture(o, texture) --set using the texture's actual size not a hardcoded size like 64/128.
        local w,h = o:texture_width(), o:texture_height()
        o:set_image(texture, w, 0, -w, h)
    end

    set_texture(radial_bg, "NepgearsyHUDReborn/HUD/HealthBG")
    set_texture(radial_health, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("HealthColor"), "Health"))
    set_texture(radial_shield, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("ShieldColor"), "Armor"))
    damage_indicator:hide() -- Thats a buggy mess anyways

    radial_bg:set_h(68)
    radial_bg:set_w(68)
    radial_health:set_h(68)
    radial_health:set_w(68)
    radial_shield:set_h(68)
    radial_shield:set_w(68)
    radial_custom:set_h(68)
    radial_custom:set_w(68)
    radial_ability_meter:set_h(68)
    radial_ability_meter:set_w(68)
    radial_absorb_shield_active:set_h(68)
    radial_absorb_shield_active:set_w(68)
    radial_absorb_health_active:set_h(68)
    radial_absorb_health_active:set_w(68)
    radial_info_meter:set_h(68)
    radial_info_meter:set_w(68)
    radial_info_meter_bg:set_h(68)
    radial_info_meter_bg:set_w(68)
    radial_ability_meter:set_h(68)
    radial_ability_meter:set_w(68)
    ability_icon:set_h(68 * 0.5)
    ability_icon:set_w(68 * 0.5)
    ability_icon:set_center(radial_health_panel:child("radial_ability"):center())
end)

function HUDTeammate:_create_weapon_panels(weapons_panel)
	local bg_color = Color.white / 3
	local w_selection_w = 12
	local weapon_panel_w = 80
	local extra_clip_w = 4
	local ammo_text_w = (weapon_panel_w - w_selection_w) / 2
	local font_bottom_align_correction = 3
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = {
		0,
		0,
		67,
		32
	}
	local weapon_selection_rect1 = {
		68,
		0,
		12,
		32
	}
	local weapon_selection_rect2 = {
		68,
		32,
		12,
		32
	}
	local primary_weapon_panel = weapons_panel:panel({
		y = 0,
		name = "primary_weapon_panel",
		h = 32,
		visible = false,
		x = 0,
		layer = 1,
		w = weapon_panel_w
	})

	primary_weapon_panel:bitmap({
		name = "bg",
		layer = 0,
		visible = true,
		x = 0,
		texture = tabs_texture,
		texture_rect = bg_rect,
		color = bg_color,
		w = weapon_panel_w
	})
	primary_weapon_panel:text({
		name = "ammo_clip",
		align = "center",
		vertical = "bottom",
		font_size = 32,
		blend_mode = "normal",
		x = 0,
		layer = 1,
		visible = true,
		text = "0" .. math.random(40),
		color = Color.white,
		w = ammo_text_w + extra_clip_w,
		h = primary_weapon_panel:h(),
		y = 0 + font_bottom_align_correction,
		font = tweak_data.hud_players.ammo_font
	})
	primary_weapon_panel:text({
		text = "000",
		name = "ammo_total",
		align = "center",
		vertical = "bottom",
		font_size = 24,
		blend_mode = "normal",
		visible = true,
		layer = 1,
		color = Color.white,
		w = ammo_text_w - extra_clip_w,
		h = primary_weapon_panel:h(),
		x = ammo_text_w + extra_clip_w,
		y = 0 + font_bottom_align_correction,
		font = tweak_data.hud_players.ammo_font
	})

	local weapon_selection_panel = primary_weapon_panel:panel({
		name = "weapon_selection",
		layer = 1,
		visible = true,
		w = w_selection_w,
		x = weapon_panel_w - w_selection_w
	})

	weapon_selection_panel:bitmap({
		name = "weapon_selection",
		texture = tabs_texture,
		texture_rect = weapon_selection_rect1,
		color = Color.white,
		w = w_selection_w
	})
	self:_create_primary_weapon_firemode()

	local secondary_weapon_panel = weapons_panel:panel({
		name = "secondary_weapon_panel",
		h = 32,
		visible = false,
		x = 0,
		layer = 1,
		w = weapon_panel_w,
		y = primary_weapon_panel:bottom()
	})

	secondary_weapon_panel:bitmap({
		name = "bg",
		layer = 0,
		visible = true,
		x = 0,
		texture = tabs_texture,
		texture_rect = bg_rect,
		color = bg_color,
		w = weapon_panel_w
	})
	secondary_weapon_panel:text({
		name = "ammo_clip",
		align = "center",
		vertical = "bottom",
		font_size = 32,
		blend_mode = "normal",
		x = 0,
		layer = 1,
		visible = true,
		text = "" .. math.random(40),
		color = Color.white,
		w = ammo_text_w + extra_clip_w,
		h = secondary_weapon_panel:h(),
		y = 0 + font_bottom_align_correction,
		font = tweak_data.hud_players.ammo_font
	})
	secondary_weapon_panel:text({
		text = "000",
		name = "ammo_total",
		align = "center",
		vertical = "bottom",
		font_size = 24,
		blend_mode = "normal",
		visible = true,
		layer = 1,
		color = Color.white,
		w = ammo_text_w - extra_clip_w,
		h = secondary_weapon_panel:h(),
		x = ammo_text_w + extra_clip_w,
		y = 0 + font_bottom_align_correction,
		font = tweak_data.hud_players.ammo_font
	})

	local weapon_selection_panel = secondary_weapon_panel:panel({
		name = "weapon_selection",
		layer = 1,
		visible = true,
		w = w_selection_w,
		x = weapon_panel_w - w_selection_w
	})

	weapon_selection_panel:bitmap({
		name = "weapon_selection",
		texture = tabs_texture,
		texture_rect = weapon_selection_rect2,
		color = Color.white,
		w = w_selection_w
	})
	secondary_weapon_panel:set_bottom(weapons_panel:h())
    self:_create_secondary_weapon_firemode()
    
    weapons_panel:set_h(68)
end

NepHook:Post(HUDTeammate, "set_state", function(self, state)
    local teammate_panel = self._panel
    local weapons_panel = self._player_panel:child("weapons_panel")
    local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
    local interact_panel = self._player_panel:child("interact_panel")
    local radial_size = 64
    local cable_ties_panel = self._player_panel:child("cable_ties_panel")
    if PlayerBase.USE_GRENADES then
        local grenades_panel = self._player_panel:child("grenades_panel")
    end
    local is_player = state == "player"
	local name = teammate_panel:child("name")

	teammate_panel:child("player"):set_alpha(is_player and 1 or 0)
    
    if is_player then
        teammate_panel:set_h(120)
        teammate_panel:child("subpanel_bg"):set_h(90)
        teammate_panel:child("subpanel_bg"):set_y(30)        
        teammate_panel:set_bottom(self.teammates:h())
        name:set_left(self.Avatar:left())
		name:set_top(teammate_panel:top() + 10)
		managers.hud:make_fine_text(name)
        self._condition_icon:set_shape(self._radial_health_panel:shape())
        self._panel:child("condition_timer"):set_shape(self._radial_health_panel:shape())
        self._player_panel:set_h(self._panel:h())
        self._radial_health_panel:set_w(68)
        self._radial_health_panel:set_h(68)
        self._radial_health_panel:set_bottom(self._panel:h() - 11)
        self.HealthNumber:set_shape(self._radial_health_panel:shape())
        self.HealthNumber:set_center(self._radial_health_panel:center())
        interact_panel:set_shape(self._radial_health_panel:shape())
        interact_panel:set_size(radial_size * 1.25, radial_size * 1.25)
        interact_panel:set_center(self._radial_health_panel:center())
        weapons_panel:set_bottom(self._radial_health_panel:bottom())
        weapons_panel:set_x(self._radial_health_panel:right() + 4)
        deployable_equipment_panel:set_top(weapons_panel:top())
        deployable_equipment_panel:set_left(weapons_panel:right() + 2)
        cable_ties_panel:set_top(deployable_equipment_panel:bottom() + 1)
        cable_ties_panel:set_left(weapons_panel:right() + 2)
        if PlayerBase.USE_GRENADES then
            local grenades_panel = self._player_panel:child("grenades_panel")
            grenades_panel:set_top(cable_ties_panel:bottom() + 1)
            grenades_panel:set_left(weapons_panel:right() + 2)
        end
        self.BGAvatar:set_bottom(self._radial_health_panel:bottom() - 2)
        self.Avatar:set_bottom(self.BGAvatar:bottom() - 2)
        self.Avatar:set_left(self.BGAvatar:left() + 2)
        self._steam_id = self:GetSteamIDByPeer()
        self:SetupAvatar()
    else
        teammate_panel:set_h(120)
        teammate_panel:child("subpanel_bg"):set_h(35)
        teammate_panel:child("subpanel_bg"):set_y(115)
        teammate_panel:set_bottom(self.teammates:h())
        name:set_bottom(teammate_panel:h() - 6)
		name:set_x(0)
        self.Avatar:set_visible(false)
        self.BGAvatar:set_visible(false)
        self._condition_icon:set_bottom(name:bottom())
        self._condition_icon:set_left(name:right() + 30)
        self._panel:child("condition_timer"):set_shape(self._condition_icon:shape())
    end
end)

NepHook:Post(HUDTeammate, "set_callsign", function(self, id)
	local name = self._panel:child("name")
	name:set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]))
    self._panel:child("subpanel_bg"):set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]))
    self.BGAvatar:set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]))
end)

NepHook:Post(HUDTeammate, "set_name", function(self, teammate_name)
    local teammate_panel = self._panel
    local name = teammate_panel:child("name")
    
    name:set_text(teammate_name)
    local h = name:h()
	managers.hud:make_fine_text(name)
	name:set_h(h)
end)

NepHook:Post(HUDTeammate, "set_health", function(self, data)
	local health = math.floor(data.current * 10)
	local HealthNumber = self._radial_health_panel:child("HealthNumber")

	HealthNumber:set_text(health)
end)

NepHook:Post(HUDTeammate, "set_carry_info", function(self, carry_id, value)
	local carry_panel = self._carry_panel
	carry_panel:set_visible(false)
end)

NepHook:Post(HUDTeammate, "layout_special_equipments", function(self)
    local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	local container_width = teammate_panel:w()
    local row_width = math.floor(container_width / 32)
    
    for i, panel in ipairs(special_equipment) do
        local zi = i - 1
        local y_pos = -math.floor(zi / row_width) * panel:h()
        
        panel:set_x(container_width - (panel:w() + 0) * (zi % row_width + 1))
        panel:set_y(y_pos)
    end
end)

NepHook:Post(HUDTeammate, "set_ammo_amount_by_type", function(self, type, max_clip, current_clip, current_left, max, weapon_panel)
    --[[local weapon_panel = self._player_panel:child("weapons_panel"):child(type .. "_weapon_panel")
    local ammo_total = weapon_panel:child("ammo_total")
    local total_left = current_left - current_clip
    local zero = total_left < 10 and "00" or total_left < 100 and "0" or ""
    local out_of_ammo = total_left <= 0
    local low_ammo = total_left <= math.round(max_clip / 2)
    local color_total = out_of_ammo and Color(1, 0.9, 0.3, 0.3)
	color_total = color_total or low_ammo and Color(1, 0.9, 0.9, 0.3)
    
    ammo_total:set_text(zero .. tostring(total_left))
    ammo_total:set_color(color_total)
	ammo_total:set_range_color(0, string.len(zero), color_total:with_alpha(0.5))--]]
end)

function HUDTeammate:GetSteamIDByPeer()
    local peer = self:peer_id() or managers.network:session():local_peer():id()
    local steam_id = managers.network:session():peer(peer):user_id()

    return tostring(steam_id)
end

function HUDTeammate:SetupAvatar()
    Steam:friend_avatar(Steam.LARGE_AVATAR, self._steam_id, function(texture)
		self.Avatar:animate(function()
			wait(0.25)
            Steam:friend_avatar(Steam.LARGE_AVATAR, self._steam_id, function(texture)
                self.Avatar:set_image(texture or "guis/textures/pd2/none_icon")
                self.Avatar:set_visible(true)
                self.BGAvatar:set_visible(true)
            end)
        end)
    end)
end

function HUDTeammate:ApplyNepgearsyHUD()
	local name = self._panel:child("name")
	local interact_panel = self._player_panel:child("interact_panel")
	local HealthNumber = self._radial_health_panel:child("HealthNumber")
    local radial_size = 64

    self._player_panel:set_w(309)

    name:set_left(self.Avatar:left())
	name:set_top(self._panel:top() + 10)

    self._radial_health_panel:set_x(self._radial_health_panel:x() + 70)
    self._weapons_panel:set_x(self._radial_health_panel:right() + 2)
    self._deployable_equipment_panel:set_x(self._weapons_panel:right() + 2)
    self._cable_ties_panel:set_x(self._weapons_panel:right() + 2)
	self._grenades_panel:set_x(self._weapons_panel:right() + 2)

	self._weapons_panel:set_y(self._radial_health_panel:top())
    self._deployable_equipment_panel:set_y(self._weapons_panel:top())
    self._cable_ties_panel:set_y(self._deployable_equipment_panel:bottom() + 2)
	self._grenades_panel:set_y(self._cable_ties_panel:bottom() + 2)
	
	interact_panel:set_shape(self._radial_health_panel:shape())
	interact_panel:set_size(radial_size * 1.25, radial_size * 1.25)
    interact_panel:set_center(self._radial_health_panel:center())
    
    self._condition_icon:set_color(Color("ff2634"))
    self._condition_icon:set_shape(self._radial_health_panel:shape())
    self._panel:child("condition_timer"):set_color(Color.black)
    self._panel:child("condition_timer"):set_shape(self._radial_health_panel:shape())
    self._panel:child("condition_timer"):set_font(Idstring("fonts/font_large_mf"))
    self._panel:child("condition_timer"):set_font_size(20)
end