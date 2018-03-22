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

    local function set_texture(o, texture) --set using the texture's actual size not a hardcoded size like 64/128.
        local w,h = o:texture_width(), o:texture_height()
        o:set_image(texture, w, 0, -w, h)
    end

    set_texture(radial_bg, "NepgearsyHUDReborn/HUD/HealthBG")
    set_texture(radial_health, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("HealthColor"), "Health"))
    set_texture(radial_shield, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("ShieldColor"), "Armor"))
    damage_indicator:hide() -- Thats a buggy mess anyways
end)

NepHook:Post(HUDTeammate, "set_state", function(self, state)
	local teammate_panel = self._panel
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
	
    name:set_left(self.Avatar:left())
	name:set_top(self._panel:top() + 10)

    self._player_panel:set_w(309)

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