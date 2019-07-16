HUDTeammateWide = HUDTeammateWide or class(HUDTeammate)
HUDTeammateWide.PADDING = 10

function HUDTeammateWide:init(i, teammates_panel, is_player, width)
    HUDTeammateWide.super.init(self, i, teammates_panel, is_player, width)

    self:_post_init(i, teammates_panel, is_player, width)
    self:_create_panel_background()
    self:_create_panel_content_background()
    self._radial_health_panel:set_x(HUDTeammateWide.PADDING * 2)
    self._radial_health_panel:set_y((self._panel_content:h() / 2) - 3)
    self:_hide_unused_elements()
    self:_apply_nepgearsy_hud_reborn_changes()
end

function HUDTeammateWide:_create_panel_background()
    self._panel_background = self._panel:bitmap({
        name = "subpanel_bg",
        texture = not self._my_panel and NepgearsyHUDReborn:GetTeammateSkinById(managers.player._player_teammate_bgs[self:peer_id()]) or NepgearsyHUDReborn:GetTeammateSkinBySave(),
        layer = -2,
        w = self._panel_width,
        h = self._panel_height
    })
end

function HUDTeammateWide:_create_panel_content_background()

    self._panel_content = self._panel:panel({
        name = "panel_content",
        w = self._panel_width - 20,
        h = self._panel_height - 35,
        x = 10
    })

    self._panel_content:set_top(self._panel:child("player_name_bg"):bottom())

    local bg = self._panel_content:bitmap({
        name = "contentpanel_bg",
        texture = "NepgearsyHUDReborn/HUD/WideTeammateSkins/default",
        w = self._panel_content:w(),
        h = self._panel_content:h(),
        alpha = 0.50,
        layer = -1
    })
end

function HUDTeammate:SetupAvatar()
    if not NepgearsyHUDReborn:HasSteamAvatarsEnabled() then
        self:set_level()

        return
    end

    Steam:friend_avatar(Steam.LARGE_AVATAR, self._steam_id, function(texture)

        self.Avatar:set_image(texture or "guis/textures/pd2/none_icon")
        self.Avatar:set_visible(true)
        if texture then
            self.BGAvatar:set_visible(true)
        else
            self.BGAvatar:set_visible(false)
        end

        DelayedCalls:Add( "NepHudAvatarRecheckFix", 0.5, function()
            Steam:friend_avatar(Steam.LARGE_AVATAR, self._steam_id, function(texture)
                self.Avatar:set_image(texture or "guis/textures/pd2/none_icon")
                self.Avatar:set_visible(true)
                if texture then
                    self.BGAvatar:set_visible(true)
                else
                    self.BGAvatar:set_visible(false)
                end
            end)
        end)
    end)

    self:set_level()
end

function HUDTeammateWide:teammate_progress(enabled, tweak_data_id, timer, success)
    self._player_panel:child("radial_health_panel"):set_alpha(enabled and 0.2 or 1)
    self._player_panel:child("interact_panel"):stop()
    self._player_panel:child("interact_panel"):set_visible(enabled)

    if enabled then
        self._player_panel:child("interact_panel"):animate(callback(HUDManager, HUDManager, "_animate_label_interact"), self._interact, timer)
    end
end

function HUDTeammateWide:set_state(state)
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
    local player_name_bg = teammate_panel:child("player_name_bg")
    local player_level = teammate_panel:child("level")
    local name_bg = teammate_panel:child("player_name_bg")

    teammate_panel:child("player"):set_alpha(is_player and 1 or 0)

    if not self._main_player then
        if is_player then
            teammate_panel:set_h(135)
			teammate_panel:set_bottom(self.teammates:h())
			name:set_left(self.Avatar:left())
			name:set_top(teammate_panel:top() + 9)
			player_level:set_top(teammate_panel:top() + 9)
			player_level:set_right(self._panel:right() - 10)
			player_name_bg:set_visible(true)
			managers.hud:make_fine_text(name)
			self._player_panel:set_h(self._panel:h())
			self._condition_icon:set_shape(self._radial_health_panel:shape())
			self._panel:child("condition_timer"):set_shape(self._radial_health_panel:shape())
			interact_panel:set_shape(self._radial_health_panel:shape())
			if NepgearsyHUDReborn:HasSteamAvatarsEnabled() then
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
			else
				weapons_panel:set_bottom(self._radial_health_panel:bottom())
				deployable_equipment_panel:set_top(weapons_panel:top())
				cable_ties_panel:set_top(deployable_equipment_panel:bottom() + 1)
				if PlayerBase.USE_GRENADES then
					local grenades_panel = self._player_panel:child("grenades_panel")
					grenades_panel:set_top(cable_ties_panel:bottom() + 1)
				end
			end     
			self.BGAvatar:set_bottom(self._radial_health_panel:bottom() - 2)
			self.Avatar:set_bottom(self.BGAvatar:bottom() - 2)
			self.Avatar:set_left(self.BGAvatar:left() + 2)
			self._steam_id = self:get_steam_id_by_peer()
			self:SetupAvatar()
            self._panel_background:set_visible(true)
            self._panel_content:set_visible(true)
        else
            name:set_bottom(teammate_panel:h())
            name:set_x(0)
            player_level:set_text("               ")
            self._panel_background:set_visible(false)
            self._panel_content:set_visible(false)
        end

        name_bg:set_position(name:x(), name:y() - 1)
    end
end

function HUDTeammateWide:_hide_unused_elements()
    local teammate_panel = self._panel
    local callsign_bg = teammate_panel:child("callsign_bg")
    local callsign = teammate_panel:child("callsign")
    local name_bg = teammate_panel:child("name_bg")

    callsign:set_visible(false)
    callsign_bg:set_visible(false)
    name_bg:set_visible(false)
end

function HUDTeammateWide:set_callsign(id)
    local name = self._panel:child("name")
    local level = self._panel:child("level")
    local name_bg = self._panel:child("player_name_bg")
    local tweakdata_color = (tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors])

    name:set_color(tweakdata_color)
    level:set_color(tweakdata_color)
    name_bg:set_color(tweakdata_color)
    --self._panel_background:set_color(tweakdata_color)
end

function HUDTeammateWide:_create_radial_health(radial_health_panel)
    self._radial_health_panel = radial_health_panel
    self._radial_health_panel:set_w(68)
    self._radial_health_panel:set_h(68)

    local radial_size = 64
    local radial_bg = radial_health_panel:bitmap({
        texture = "guis/textures/pd2/hud_radialbg",
        name = "radial_bg",
        alpha = 1,
        layer = 0,
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    local radial_health = radial_health_panel:bitmap({
        texture = "guis/textures/pd2/hud_health",
        name = "radial_health",
        layer = 2,
        blend_mode = "add",
        render_template = "VertexColorTexturedRadial",
        texture_rect = {
            128,
            0,
            -128,
            128
        },
        color = Color(1, 0, 1, 1),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    local radial_shield = radial_health_panel:bitmap({
        texture = "guis/textures/pd2/hud_shield",
        name = "radial_shield",
        layer = 1,
        blend_mode = "add",
        render_template = "VertexColorTexturedRadial",
        texture_rect = {
            128,
            0,
            -128,
            128
        },
        color = Color(1, 0, 1, 1),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    local damage_indicator = radial_health_panel:bitmap({
        blend_mode = "add",
        name = "damage_indicator",
        alpha = 0,
        texture = "guis/textures/pd2/hud_radial_rim",
        layer = 1,
        color = Color(1, 1, 1, 1),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    local radial_custom = radial_health_panel:bitmap({
        texture = "guis/textures/pd2/hud_swansong",
        name = "radial_custom",
        blend_mode = "add",
        visible = false,
        render_template = "VertexColorTexturedRadial",
        layer = 5,
        color = Color(1, 0, 0, 0),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    local radial_ability_panel = radial_health_panel:panel({
        visible = false,
        name = "radial_ability"
    })
    local radial_ability_meter = radial_ability_panel:bitmap({
        blend_mode = "add",
        name = "ability_meter",
        texture = "guis/textures/pd2/hud_fearless",
        render_template = "VertexColorTexturedRadial",
        layer = 5,
        color = Color(1, 0, 0, 0),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    local radial_ability_icon = radial_ability_panel:bitmap({
        blend_mode = "add",
        name = "ability_icon",
        alpha = 1,
        layer = 5,
        w = radial_size * 0.5,
        h = radial_size * 0.5
    })

    radial_ability_icon:set_center(radial_ability_panel:center())

    local radial_delayed_damage_panel = radial_health_panel:panel({name = "radial_delayed_damage"})
    local radial_delayed_damage_armor = radial_delayed_damage_panel:bitmap({
        texture = "guis/textures/pd2/hud_dot_shield",
        name = "radial_delayed_damage_armor",
        visible = false,
        render_template = "VertexColorTexturedRadialFlex",
        layer = 5,
        w = radial_delayed_damage_panel:w(),
        h = radial_delayed_damage_panel:h()
    })
    local radial_delayed_damage_health = radial_delayed_damage_panel:bitmap({
        texture = "guis/textures/pd2/hud_dot",
        name = "radial_delayed_damage_health",
        visible = false,
        render_template = "VertexColorTexturedRadialFlex",
        layer = 5,
        w = radial_delayed_damage_panel:w(),
        h = radial_delayed_damage_panel:h()
    })

    if self._main_player then
        local radial_rip = radial_health_panel:bitmap({
            texture = "guis/textures/pd2/hud_rip",
            name = "radial_rip",
            layer = 3,
            blend_mode = "add",
            visible = false,
            render_template = "VertexColorTexturedRadial",
            texture_rect = {
                128,
                0,
                -128,
                128
            },
            color = Color(1, 0, 0, 0),
            w = radial_health_panel:w(),
            h = radial_health_panel:h()
        })
        local radial_rip_bg = radial_health_panel:bitmap({
            texture = "guis/textures/pd2/hud_rip_bg",
            name = "radial_rip_bg",
            layer = 1,
            visible = false,
            render_template = "VertexColorTexturedRadial",
            texture_rect = {
                128,
                0,
                -128,
                128
            },
            color = Color(1, 0, 0, 0),
            w = radial_health_panel:w(),
            h = radial_health_panel:h()
        })
    end

    radial_health_panel:bitmap({
        texture = "guis/dlcs/coco/textures/pd2/hud_absorb_shield",
        name = "radial_absorb_shield_active",
        visible = false,
        render_template = "VertexColorTexturedRadial",
        layer = 5,
        color = Color(1, 0, 0, 0),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })

    local radial_absorb_health_active = radial_health_panel:bitmap({
        texture = "guis/dlcs/coco/textures/pd2/hud_absorb_health",
        name = "radial_absorb_health_active",
        visible = false,
        render_template = "VertexColorTexturedRadial",
        layer = 5,
        color = Color(1, 0, 0, 0),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })

    radial_absorb_health_active:animate(callback(self, self, "animate_update_absorb_active"))
    radial_health_panel:bitmap({
        texture = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_fg",
        name = "radial_info_meter",
        blend_mode = "add",
        visible = false,
        render_template = "VertexColorTexturedRadial",
        layer = 3,
        color = Color(1, 0, 0, 0),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    radial_health_panel:bitmap({
        texture = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_bg",
        name = "radial_info_meter_bg",
        layer = 1,
        visible = false,
        render_template = "VertexColorTexturedRadial",
        texture_rect = {
            128,
            0,
            -128,
            128
        },
        color = Color(1, 0, 0, 0),
        w = radial_health_panel:w(),
        h = radial_health_panel:h()
    })
    self:_create_condition(radial_health_panel)

    if NepgearsyHUDReborn.Options:GetValue("HealthStyle") == 1 then
        local function set_texture(o, texture) --set using the texture's actual size not a hardcoded size like 64/128.
            local w,h = o:texture_width(), o:texture_height()
            o:set_image(texture, w, 0, -w, h)
        end

        set_texture(radial_bg, "NepgearsyHUDReborn/HUD/HealthBG")
        set_texture(radial_health, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("HealthColor"), "Health"))
        set_texture(radial_shield, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("ShieldColor"), "Armor"))
        damage_indicator:hide() -- Thats a buggy mess anyways
    end
end

function HUDTeammateWide:_create_weapon_panels(weapons_panel)
    weapons_panel:set_h(68)

    local bg_color = Color.white / 3
    local w_selection_w = 12
    local weapon_panel_w = 90
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
        texture = "NepgearsyHUDReborn/HUD/PlayerNameBG",
        color = Color(0.25, 0.25, 0.25),
        alpha = 0.85,
        w = weapon_panel_w,
        h = 32
    })
    self.BGWeaponPanelPrimary = primary_weapon_panel:child("bg")
    primary_weapon_panel:text({
        name = "ammo_clip",
        align = "right",
        vertical = "bottom",
        font_size = 30,
        blend_mode = "normal",
        x = -2,
        layer = 1,
        visible = true,
        text = "0" .. math.random(40),
        color = Color.white,
        w = ammo_text_w + extra_clip_w,
        h = primary_weapon_panel:h(),
        y = 0,
        font = "fonts/font_large_mf"
    })
    primary_weapon_panel:text({
        text = "000",
        name = "ammo_total",
        align = "left",
        vertical = "bottom",
        font_size = 20,
        blend_mode = "normal",
        visible = true,
        layer = 1,
        color = Color.white,
        w = ammo_text_w - extra_clip_w,
        h = primary_weapon_panel:h(),
        x = ammo_text_w + extra_clip_w,
        y = -2,
        font = "fonts/font_large_mf"
    })
    
    local weapon_selection_panel = primary_weapon_panel:panel({
        name = "weapon_selection",
        layer = 1,
        visible = false,
        w = w_selection_w,
        x = weapon_panel_w - w_selection_w
    })

    weapon_selection_panel:bitmap({
        name = "weapon_selection",
        texture = tabs_texture,
        texture_rect = weapon_selection_rect1,
        color = Color.white,
        w = w_selection_w,
        visible = false
    })

    --self:_create_primary_weapon_firemode()

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
        texture = "NepgearsyHUDReborn/HUD/PlayerNameBG",
        color = Color(0.25, 0.25, 0.25),
        alpha = 0.85,
        w = weapon_panel_w,
        h = 32
    })
    self.BGWeaponPanelSecondary = secondary_weapon_panel:child("bg")
    secondary_weapon_panel:text({
        name = "ammo_clip",
        align = "right",
        vertical = "bottom",
        font_size = 30,
        blend_mode = "normal",
        x = -2,
        layer = 1,
        visible = true,
        text = "" .. math.random(40),
        color = Color.white,
        w = ammo_text_w + extra_clip_w,
        h = secondary_weapon_panel:h(),
        y = 0,
        font = "fonts/font_large_mf"
    })
    secondary_weapon_panel:text({
        text = "000",
        name = "ammo_total",
        align = "left",
        vertical = "bottom",
        font_size = 20,
        blend_mode = "normal",
        visible = true,
        layer = 1,
        color = Color.white,
        w = ammo_text_w - extra_clip_w,
        h = secondary_weapon_panel:h(),
        x = ammo_text_w + extra_clip_w,
        y = -2,
        font = "fonts/font_large_mf"
    })

    local weapon_selection_panel = secondary_weapon_panel:panel({
        name = "weapon_selection",
        layer = 1,
        visible = false,
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

    --self:_create_secondary_weapon_firemode()
end

function HUDTeammateWide:get_steam_id_by_peer()
    local peer = self:peer_id() or managers.network:session():local_peer():id()
    local steam_id = managers.network:session():peer(peer):user_id()

    return tostring(steam_id)
end

function HUDTeammateWide:set_level()
    if not NepgearsyHUDReborn:GetOption("EnablePlayerLevel") then
        return
    end

    local user_id = self:get_steam_id_by_peer()
    local panel = self._panel:child("level")

    panel:set_visible(true)

    if not user_id or user_id == 0 or user_id == "" then
        log("no uid for panel number " .. self._i)
        return
    end

    if not self._my_panel then
        local peer_data = managers.network:session():peer_by_user_id(user_id)
        local infamy = ""

        if peer_data:rank() > 0 then
            infamy = managers.experience:rank_string(peer_data:rank()) .. "-"
        end

        local level = peer_data:level()

        panel:set_text(infamy .. level)
    else
        local my_infamy = ""

        if managers.experience:current_rank() > 0 then
            my_infamy = managers.experience:rank_string(managers.experience:current_rank()) .. "-"
        end

        local local_data = {
            level = managers.experience:current_level(),
            rank = my_infamy
        }

        panel:set_text(local_data.rank .. local_data.level)
    end
end

NepHook:Post(HUDTeammate, "set_health", function(self, data)
    if NepgearsyHUDReborn.Options:GetValue("StatusNumberType") == 1 or NepgearsyHUDReborn.Options:GetValue("StatusNumberType") == 3 then
        local health = math.floor(data.current * 10)
        local HealthNumber = self._radial_health_panel:child("HealthNumber")

        HealthNumber:set_text(health)
    end
end)

NepHook:Post(HUDTeammate, "set_armor", function(self, data)
    local armor = math.floor(data.current * 10)

    if NepgearsyHUDReborn.Options:GetValue("StatusNumberType") == 2 then

        local ArmorNumber = self._radial_health_panel:child("HealthNumber")
        ArmorNumber:set_text(armor)

    elseif NepgearsyHUDReborn.Options:GetValue("StatusNumberType") == 3 then

        local ArmorNumber = self._radial_health_panel:child("ArmorNumber")
        ArmorNumber:set_text(armor)
    end
end)

NepHook:Post(HUDTeammate, "set_carry_info", function(self, carry_id, value)
    local teammate_panel = self._panel
    local name = teammate_panel:child("name")
    local carry_panel = self._carry_panel

    carry_panel:set_bottom(name:bottom())
    carry_panel:set_left(name:right() + 5)
end)

function HUDTeammateWide:_post_init(i, teammates_panel, is_player, width)
    local MyPanel = i == HUDManager.PLAYER_PANEL
    self._my_panel = MyPanel
    self._i = i
    self._panel_width = width
    self._panel_height = 135
    self.teammates = teammates_panel

    local name = self._panel:child("name")
    local player_font_choice = NepgearsyHUDReborn.Options:GetValue("PlayerNameFont")
    local player_font = "fonts/font_eurostile_ext"

    if player_font_choice == 2 then
        player_font = "fonts/font_large_mf"
    end

    local name_bg = self._panel:bitmap({
        name = "player_name_bg",
        color = Color.white,
        layer = -1,
        texture = "NepgearsyHUDReborn/HUD/PlayerNameBG",
        w = self._panel:w() - 15,
        h = 20,
        y = 8,
        x = 8
    })

    name:configure({
        vertical = "center",
        layer = 1,
        font = player_font,
        font_size = tweak_data.hud_players.name_size,
        y = 8,
        x = 5
    })
    managers.hud:make_fine_text(name)

    local level = self._panel:text({
        name = "level",
        vertical = "center",
        y = 0,
        layer = 1,
        align = "right",
        text = "               ",
        font_size = tweak_data.hud_players.name_size,
        font = player_font,
        visible = NepgearsyHUDReborn:GetOption("EnablePlayerLevel")
    })
    managers.hud:make_fine_text(level)

    level:set_top(self._panel:top() + 8)
    level:set_right(self._panel:right() - 10)
    
    self._panel:set_h(135)
    self._panel:set_w(self._panel_width)
    self._panel:set_bottom(teammates_panel:h())

    local health_bg = self._radial_health_panel:bitmap({
        name = "health_bg",
        texture = "NepgearsyHUDReborn/HUD/HealthShadow",
        color = Color.white,
        layer = -1,
        h = self._radial_health_panel:h(),
        w = self._radial_health_panel:w()
    })

    local health_numeral_color = NepgearsyHUDReborn:StringToColor("numeral_status_color", NepgearsyHUDReborn:GetOption("HealthColor"))
    local armor_numeral_color = NepgearsyHUDReborn:StringToColor("numeral_status_color", NepgearsyHUDReborn:GetOption("ShieldColor"))
    local is_both_numbers_visible = NepgearsyHUDReborn:GetOption("StatusNumberType") == 3
    local is_numeral_visible = NepgearsyHUDReborn:GetOption("StatusNumberType") ~= 4

    local HealthNumber = self._radial_health_panel:text({
        name = "HealthNumber",
        font = "fonts/font_large_mf",
        font_size = 16,
        text = "",
        color = is_both_numbers_visible and health_numeral_color or Color.white,
        align = "center",
        vertical = "center",
        y = is_both_numbers_visible and -5 or 0,
        layer = 1,
        visible = is_numeral_visible
    })

    local ArmorNumber = self._radial_health_panel:text({
        name = "ArmorNumber",
        font = "fonts/font_large_mf",
        font_size = 13,
        text = "",
        color = is_both_numbers_visible and armor_numeral_color or Color.white,
        align = "center",
        y = is_both_numbers_visible and 10 or 0,
        vertical = "center",
        layer = 1,
        visible = is_numeral_visible
    })

    self.BGAvatar = self._panel:rect({
        name = "BGAvatar",
        color = Color.black,
        layer = 0,
        h = 64,
        w = 64,
        x = 2,
        visible = NepgearsyHUDReborn:HasSteamAvatarsEnabled()
    })
    self.Avatar = self._panel:bitmap({
        texture = "guis/textures/pd2/none_icon",
        h = 60,
        w = 60,
        layer = 1,
        visible = NepgearsyHUDReborn:HasSteamAvatarsEnabled()
    })
    self.BGAvatar:set_bottom(self._radial_health_panel:bottom() - 2)
    self.Avatar:set_bottom(self.BGAvatar:bottom() - 2)
    self.Avatar:set_left(self.BGAvatar:left() + 2)

    if MyPanel then
        self._steam_id = self:get_steam_id_by_peer()
        self:SetupAvatar()
    end

    local debug_rect = self._panel:rect({
        color = Color(255, 0, 0),
        alpha = 0.35,
        layer = -100,
        w = self._panel:w(),
        h = self._panel:h(),
        visible = false
    })
end

function HUDTeammateWide:set_ammo_amount_by_type(type, max_clip, current_clip, current_left, max, weapon_panel)
    local weapon_panel = weapon_panel or self._player_panel:child("weapons_panel"):child(type .. "_weapon_panel")
    weapon_panel:set_visible(true)

    local TrueAmmo = NepgearsyHUDReborn:GetOption("EnableTrueAmmo")

    local weapon_panel = self._player_panel:child("weapons_panel"):child(type .. "_weapon_panel")
    local ammo_total = weapon_panel:child("ammo_total")
    local ammo_clip = weapon_panel:child("ammo_clip")
    local total_left = current_left

    if TrueAmmo then
        total_left = current_left - current_clip

        if total_left < 0 then
            total_left = current_left
        end
    end

    local low_ammo = total_left <= math.round(max_clip / 2)
    local low_ammo_clip = current_clip <= math.round(max_clip / 4)
    local out_of_ammo_clip = current_clip <= 0
    local out_of_ammo = total_left <= 0
    local no_ammo_color = Color(1, 0.9, 0.3, 0.3)
    local low_ammo_color = Color(1, 0.9, 0.9, 0.3)

    ammo_total:set_color(Color.white)
    ammo_clip:set_color(Color.white)

    ammo_clip:set_font_size(string.len(current_clip) < 4 and 30 or 22)
    ammo_total:set_font_size(string.len(current_left) < 4 and 20 or 16)

    if low_ammo then
        ammo_total:set_color(low_ammo_color)
    end

    if low_ammo_clip then
        ammo_clip:set_color(low_ammo_color)
    end

    if out_of_ammo_clip then
        ammo_clip:set_color(no_ammo_color)
    end

    if out_of_ammo then
        ammo_total:set_color(no_ammo_color)
    end

    ammo_clip:set_text(tostring(current_clip))
    ammo_total:set_text(" / " .. tostring(total_left))
    ammo_total:set_range_color(0, 1, Color(0.8, 0.8, 0.8))
end

NepHook:Post(HUDTeammate, "_create_equipment_panels", function(self, player_panel)
    -- Unlike ovk, I do use player_panel.

    local new_texture = "NepgearsyHUDReborn/HUD/PlayerNameBG"
    local deployable_bg = player_panel:child("deployable_equipment_panel"):child("bg")
    local cable_ties_bg = player_panel:child("cable_ties_panel"):child("bg")
    player_panel:child("deployable_equipment_panel"):set_h(player_panel:child("deployable_equipment_panel"):h() + 1)
    player_panel:child("cable_ties_panel"):set_h(player_panel:child("cable_ties_panel"):h() + 1)

    deployable_bg:set_image(new_texture)
    deployable_bg:set_color(Color.white / 1.5)
    deployable_bg:set_size(player_panel:child("deployable_equipment_panel"):w(), player_panel:child("deployable_equipment_panel"):h())
    player_panel:child("deployable_equipment_panel"):child("amount"):set_font(Idstring("fonts/font_large_mf"))
    player_panel:child("deployable_equipment_panel"):child("amount"):set_font_size(22)

    cable_ties_bg:set_image(new_texture)
    cable_ties_bg:set_color(Color.white / 1.5)
    cable_ties_bg:set_size(player_panel:child("cable_ties_panel"):w(), player_panel:child("cable_ties_panel"):h())
    player_panel:child("cable_ties_panel"):child("amount"):set_font(Idstring("fonts/font_large_mf"))
    player_panel:child("cable_ties_panel"):child("amount"):set_font_size(22)

    if PlayerBase.USE_GRENADES then
        local grenade_bg = player_panel:child("grenades_panel"):child("bg")
        player_panel:child("grenades_panel"):set_h(player_panel:child("grenades_panel"):h() + 1)

        grenade_bg:set_image(new_texture)
        grenade_bg:set_color(Color.white / 1.5)
        grenade_bg:set_size(player_panel:child("grenades_panel"):w(), player_panel:child("grenades_panel"):h())
        player_panel:child("grenades_panel"):child("amount"):set_font(Idstring("fonts/font_large_mf"))
        player_panel:child("grenades_panel"):child("amount"):set_font_size(22)
    end
end)

function HUDTeammateWide:_update_player_bg(texture)
    if self._my_panel then
        return
    end

    if texture then
        self._panel:child("subpanel_bg"):set_image(texture)
    end
end

function HUDTeammateWide:_apply_nepgearsy_hud_reborn_changes()
    self._weapons_panel = self._player_panel:child("weapons_panel")
    local interact_panel = self._player_panel:child("interact_panel")
    interact_panel:set_shape(self._radial_health_panel:shape())
    interact_panel:set_size(60 * 1.25, 60 * 1.25)
    interact_panel:set_center(self._radial_health_panel:center())

    local radius = interact_panel:h() / 2 - 4
    self._interact = CircleBitmapGuiObject:new(interact_panel, {
        blend_mode = "add",
        use_bg = true,
        rotation = 360,
        layer = 0,
        radius = radius,
        color = Color.white
    })

    self._deployable_equipment_panel:set_x(self._panel_content:right() - 50)
    self._cable_ties_panel:set_x(self._panel_content:right() - 50)
    self._grenades_panel:set_x(self._panel_content:right() - 50)
    self._weapons_panel:set_x(self._deployable_equipment_panel:left() - self._weapons_panel:w() - 5)

    self._weapons_panel:set_y(self._radial_health_panel:top())
    self._deployable_equipment_panel:set_y(self._weapons_panel:top())
    self._cable_ties_panel:set_y(self._deployable_equipment_panel:bottom() + 2)
    self._grenades_panel:set_y(self._cable_ties_panel:bottom() + 2)
end