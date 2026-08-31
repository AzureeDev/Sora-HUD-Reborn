if not NepgearsyHUDReborn:IsTeammatePanelWide() then
	local init_orig = HUDTeammate.init
	function HUDTeammate:init(i, teammates_panel, is_player, width)
		init_orig(self, i, teammates_panel, is_player, width)
		self._is_ai = false
		local name = self._panel:child("name")

		local player_font = "fonts/font_large_mf"
		if NepgearsyHUDReborn:GetOption("PlayerNameFont") == 2 then
			player_font = "fonts/font_eurostile_ext"
		elseif NepgearsyHUDReborn:GetOption("PlayerNameFont") == 3 then
			player_font = "fonts/font_pdth"
		end
		player_font = NepgearsyHUDReborn:SetFont(player_font)

		self._panel:child("name_bg"):set_visible(false)
		self._panel:child("callsign_bg"):set_visible(false)
		self._panel:child("callsign"):set_visible(false)
		self._player_panel:child("revive_panel"):set_visible(false)

		local name_bg = self._panel:bitmap({
			name = "player_name_bg",
			color = Color.white,
			layer = -1,
			texture = "NepgearsyHUDReborn/HUD/PlayerNameBG",
			w = 309,
			h = 20,
			y = 8
		})

		name:configure({
			vertical = "center",
			align = "left",
			layer = 1,
			font = player_font,
			font_size = tweak_data.hud_players.name_size
		})
		managers.hud:make_fine_text(name)

		local level = self._panel:text({
			name = "level",
			vertical = "center",
			y = 0,
			layer = 1,
			align = "right",
			text = "                              ",
			font_size = tweak_data.hud_players.name_size,
			font = player_font,
			visible = NepgearsyHUDReborn:GetOption("EnablePlayerLevel")
		})
		managers.hud:make_fine_text(level)

		local subpanel_bg = self._panel:bitmap({
			name = "subpanel_bg",
			color = NepgearsyHUDReborn:GetOption("ColorWithSkinPanels") and Color.green or nil,
			layer = -2,
			texture = not self._main_player and NepgearsyHUDReborn:GetTeammateSkinById(managers.player._player_teammate_bgs[self:peer_id()]) or NepgearsyHUDReborn:GetTeammateSkinBySave(),
			w = 269,
			h = 90,
			y = 30
		})

		self._radial_health_panel:set_bottom(self._panel:h() - 11)

		local health_bg = self._radial_health_panel:bitmap({
			name = "health_bg",
			texture = "NepgearsyHUDReborn/HUD/HealthShadow",
			color = Color.white,
			layer = -1,
			h = self._radial_health_panel:h(),
			w = self._radial_health_panel:w()
		})

		local health_numeral_color = NepgearsyHUDReborn:StringToColor(NepgearsyHUDReborn:GetOption("HealthColor"))
		local armor_numeral_color = NepgearsyHUDReborn:StringToColor(NepgearsyHUDReborn:GetOption("ShieldColor"))
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

		local revive_panel = self._panel:panel({
			name = "revive_panel2",
			w = 40,
			h = 40,
			layer = 2,
			color = Color.red,
			x = self._radial_health_panel:left() + 110,
			y = self._radial_health_panel:top() - 16,
			visible = NepgearsyHUDReborn:GetOption("EnableDownCounter")
		})

		local revive_icon = revive_panel:bitmap({
			name = "revive_icon",
			color = Color.white,
			layer = 2,
			texture = NepgearsyHUDReborn:GetOption("EnableSteamAvatars") and "NepgearsyHUDReborn/HUD/DownCounterIconHeartOnly" or "NepgearsyHUDReborn/HUD/DownCounterIcon",
			w = 40,
			h = 40
		})

		revive_panel:text({
			text = "2x",
			name = "revive_amt",
			font_size = 13,
			font = "fonts/font_large_mf",
			align = "center",
			layer = 3,
			color = Color.black,
			y = 13
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
			x = 2,
			visible = false
		})

		self.Avatar = self._panel:bitmap({
			texture = "guis/textures/pd2/none_icon",
			h = 60,
			w = 60,
			layer = 1,
			visible = NepgearsyHUDReborn:GetOption("EnableSteamAvatars")
		})
		self.BGAvatar:set_bottom(self._radial_health_panel:bottom() - 2)
		self.Avatar:set_bottom(self.BGAvatar:bottom() - 2)
		self.Avatar:set_left(self.BGAvatar:left() + 2)

		if self._main_player then
			if NepgearsyHUDReborn:GetOption("EnableSteamAvatars") then
				self:SetupAccountAvatar()
			end
			if NepgearsyHUDReborn:GetOption("EnablePlayerLevel") then
				self:set_level()
			end

			if NepgearsyHUDReborn:GetOption("EnableHPSMeter") then
				self._hps_meter_panel = self._panel:panel({
					name = "hps_meter_panel",
					x = 0,
					y = 0,
					vertical = "center",
					align = "left",
					visible = true
				})
				self._hps_meter_panel:set_top(self._panel:top() + 8)

				self._hps_meter = self._hps_meter_panel:text({
					name = "hps_meter",
					text = "|",
					color = Color.white,
					x = 4,
					y = 1,
					visible = false,
					align = "left",
					vertical = "top",
					font = player_font,
					font_size = tweak_data.hud_players.name_size,
					layer = 4
				})
			end
		end

		local weapons_panel = self._weapons_panel
		local radial_size = 60
		local interact_panel = self._player_panel:child("interact_panel")
		local carry_panel = self._player_panel:child("carry_panel")
		local carry_panel_bitmap = carry_panel:child("bg")

		self._player_panel:set_w(309)

		name:set_left(self.Avatar:left())
		name:set_top(self._panel:top() + 9)
		level:set_top(self._panel:top() + 9)
		level:set_right(self._panel:right() - 3)

		carry_panel:set_h(23)
		carry_panel:set_w(24)
		carry_panel_bitmap:set_h(23)
		carry_panel_bitmap:set_w(24)

		self._radial_health_panel:set_x(self._radial_health_panel:x() + 70)
		weapons_panel:set_x(self._radial_health_panel:right() + 2)
		self._deployable_equipment_panel:set_x(weapons_panel:right() + 2)
		self._cable_ties_panel:set_x(weapons_panel:right() + 2)
		self._grenades_panel:set_x(weapons_panel:right() + 2)

		weapons_panel:set_y(self._radial_health_panel:top())
		self._deployable_equipment_panel:set_y(weapons_panel:top())
		self._cable_ties_panel:set_y(self._deployable_equipment_panel:bottom() + 2)
		self._grenades_panel:set_y(self._cable_ties_panel:bottom() + 2)

		self._condition_icon:set_color(Color("89141c"))
		self._condition_icon:set_shape(self._radial_health_panel:shape())
		self._panel:child("condition_timer"):set_color(Color.black)
		self._panel:child("condition_timer"):set_shape(self._radial_health_panel:shape())
		self._panel:child("condition_timer"):set_font(Idstring("fonts/font_large_mf"))
		self._panel:child("condition_timer"):set_font_size(20)

		interact_panel:set_shape(weapons_panel:shape())
		interact_panel:set_shape(self._radial_health_panel:shape())
		interact_panel:set_size(radial_size * 1.25, radial_size * 1.25)
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

		if not NepgearsyHUDReborn:GetOption("EnableSteamAvatars") then
			self._radial_health_panel:set_x(self.Avatar:x())
			self._radial_health_panel:set_y(self.Avatar:y() - 4)
			self._panel:child("revive_panel2"):set_x(self._radial_health_panel:left() + 60)
			self._panel:child("revive_panel2"):set_y(self._radial_health_panel:top() - 8)
			--weapons_panel:set_x(self._radial_health_panel:right() + 35)
		else
			self._panel:child("revive_panel2"):set_x(self._radial_health_panel:left() + 44)
			self._panel:child("revive_panel2"):set_y(self._radial_health_panel:top() - 13)
		end
	end

	function HUDTeammate:_create_radial_health(radial_health_panel)
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

		local radial_delayed_damage_panel = radial_health_panel:panel({
			name = "radial_delayed_damage"
		})
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

		local copr_overlay_panel = radial_health_panel:panel({
			name = "copr_overlay_panel",
			layer = 3,
			w = radial_health_panel:w(),
			h = radial_health_panel:h()
		})

		self:_create_condition(radial_health_panel)

		if NepgearsyHUDReborn:GetOption("HealthStyle") == 1 then
			local function set_texture(o, texture) --set using the texture's actual size not a hardcoded size like 64/128.
				local w, h = o:texture_width(), o:texture_height()
				o:set_image(texture, w, 0, -w, h)
			end

			set_texture(radial_bg, "NepgearsyHUDReborn/HUD/HealthBG")
			set_texture(radial_health, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("HealthColor"), "Health"))
			set_texture(radial_shield, NepgearsyHUDReborn:TeammateRadialIDToPath(NepgearsyHUDReborn:GetOption("ShieldColor"), "Armor"))
			damage_indicator:hide() -- Thats a buggy mess anyways
		end
	end

	function HUDTeammate:_create_weapon_panels(weapons_panel)
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
			color = Color(0.4, 0.4, 0.4),
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
			y = 3,
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
			y = 0,
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
			texture = "NepgearsyHUDReborn/HUD/PlayerNameBG",
			color = Color(0.4, 0.4, 0.4),
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
			y = 3,
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
			y = 0,
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
		self:_create_secondary_weapon_firemode()
	end

	function HUDTeammate:set_weapon_firemode(id, firemode, ...)
		local is_secondary = id == 1
		local weapons_panel = self._player_panel:child("weapons_panel"):child(is_secondary and "secondary_weapon_panel" or "primary_weapon_panel")

		if alive(weapons_panel) then
			local firemode_single = weapons_panel:child("firemode_single")
			local firemode_auto = weapons_panel:child("firemode_auto")
			local firemode_burst = weapons_panel:child("firemode_burst")

			local is_alt = select(1, ...)

			if is_alt then
				if firemode == "single" then
					firemode = "auto"
				else
					firemode = "single"
				end
			end

			if alive(firemode_single) and alive(firemode_auto) and alive(firemode_burst) then
				firemode_single:set_visible(firemode == "single")
				firemode_auto:set_visible(firemode == "auto")
				firemode_burst:set_visible(firemode == "burst")
			end
		end
	end

	function HUDTeammate:_create_primary_weapon_firemode()
		local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
		local old_single = primary_weapon_panel:child("firemode_single")
		local old_auto = primary_weapon_panel:child("firemode_auto")
		local old_burst = primary_weapon_panel:child("firemode_burst")

		if alive(old_single) then
			primary_weapon_panel:remove(old_single)
		end

		if alive(old_auto) then
			primary_weapon_panel:remove(old_auto)
		end

		if alive(old_burst) then
			primary_weapon_panel:remove(old_burst)
		end

		if self._main_player then
			local equipped = managers.blackmarket:equipped_primary()
			local weapon_tweak_data = tweak_data.weapon[equipped.weapon_id]
			local fire_mode = weapon_tweak_data.FIRE_MODE
			local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE

			--[[
			local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped.factory_id, equipped.blueprint)
			local locked_to_burst = managers.weapon_factory:has_perk("fire_mode_burst", equipped.factory_id, equipped.blueprint)
			local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped.factory_id, equipped.blueprint)

			if locked_to_auto then
				fire_mode = "auto"
			elseif locked_to_burst then
				fire_mode = "burst"
			elseif locked_to_single then
				fire_mode = "single"
			end

			local is_locked = locked_to_auto or locked_to_burst or locked_to_single
			local color = Color.white
			if not can_toggle_firemode then
				color = Color(1, 0.4, 0.4)
			elseif is_locked then
				color = Color(1, 1, 0.4)
			end
			]]

			local firemode = function(name, text)
				return primary_weapon_panel:text({
					name = name,
					text = text,
					font = "fonts/font_small_shadow_mf",
					font_size = 8,
					layer = 2,
					color = can_toggle_firemode and Color.white or Color(1, 0.4, 0.4),
					visible = false,
					x = -10,
					align = "right"
				})
			end

			local firemode_primary = firemode("firemode_single", "SINGLE")
			--firemode_primary:set_center_x()
			--firemode_primary:set_top(primary_weapon_panel:h() - 2)
			firemode_primary:set_bottom(primary_weapon_panel:h())

			local firemode_secondary = firemode("firemode_auto", "AUTO")
			--firemode_secondary:set_top(primary_weapon_panel:h() - 2)
			firemode_secondary:set_bottom(primary_weapon_panel:h())

			local firemode_burst = firemode("firemode_burst", "BURST")
			--firemode_burst:set_top(primary_weapon_panel:h() - 2)
			firemode_burst:set_bottom(primary_weapon_panel:h())

			if fire_mode == "single" then
				firemode_primary:show()
			elseif fire_mode == "burst" then
				firemode_burst:show()
			else
				firemode_secondary:show()
			end
		end
	end

	function HUDTeammate:_create_secondary_weapon_firemode()
		local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
		local old_single = secondary_weapon_panel:child("firemode_single")
		local old_auto = secondary_weapon_panel:child("firemode_auto")
		local old_burst = secondary_weapon_panel:child("firemode_burst")

		if alive(old_single) then
			secondary_weapon_panel:remove(old_single)
		end

		if alive(old_auto) then
			secondary_weapon_panel:remove(old_auto)
		end

		if alive(old_burst) then
			secondary_weapon_panel:remove(old_burst)
		end

		if self._main_player then
			local equipped = managers.blackmarket:equipped_secondary()
			local weapon_tweak_data = tweak_data.weapon[equipped.weapon_id]
			local fire_mode = weapon_tweak_data.FIRE_MODE
			local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE

			--[[
			local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped.factory_id, equipped.blueprint)
			local locked_to_burst = managers.weapon_factory:has_perk("fire_mode_burst", equipped.factory_id, equipped.blueprint)
			local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped.factory_id, equipped.blueprint)

			if locked_to_auto then
				fire_mode = "auto"
			elseif locked_to_burst then
				fire_mode = "burst"
			elseif locked_to_single then
				fire_mode = "single"
			end

			local is_locked = locked_to_auto or locked_to_burst or locked_to_single
			local color = Color.white
			if not can_toggle_firemode then
				color = Color(1, 0.4, 0.4)
			elseif is_locked then
				color = Color(1, 1, 0.4)
			end
			]]

			local firemode = function(name, text)
				return secondary_weapon_panel:text({
					name = name,
					text = text,
					font = "fonts/font_small_shadow_mf",
					font_size = 8,
					layer = 2,
					color = can_toggle_firemode and Color.white or Color(1, 0.4, 0.4),
					visible = false,
					x = -10,
					align = "right"
				})
			end

			local firemode_primary = firemode("firemode_single", "SINGLE")
			--firemode_primary:set_center_x()
			--firemode_primary:set_top(secondary_weapon_panel:h() - 2)
			firemode_primary:set_bottom(secondary_weapon_panel:h())

			local firemode_secondary = firemode("firemode_auto", "AUTO")
			--firemode_secondary:set_top(secondary_weapon_panel:h() - 2)
			firemode_secondary:set_bottom(secondary_weapon_panel:h())

			local firemode_burst = firemode("firemode_burst", "BURST")
			--firemode_burst:set_top(secondary_weapon_panel:h() - 2)
			firemode_burst:set_bottom(secondary_weapon_panel:h())

			if fire_mode == "single" then
				firemode_primary:show()
			elseif fire_mode == "burst" then
				firemode_burst:show()
			else
				firemode_secondary:show()
			end
		end
	end

	function HUDTeammate:set_state(state)
		local teammate_panel = self._panel
		local weapons_panel = self._player_panel:child("weapons_panel")
		local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
		local interact_panel = self._player_panel:child("interact_panel")
		local radial_size = 64
		local cable_ties_panel = self._player_panel:child("cable_ties_panel")
		local grenades_panel = self._player_panel:child("grenades_panel")
		local is_player = state == "player"
		local name = teammate_panel:child("name")
		local player_name_bg = teammate_panel:child("player_name_bg")
		local player_level = teammate_panel:child("level")

		teammate_panel:child("player"):set_alpha(is_player and 1 or 0)
		teammate_panel:set_h(120)
		teammate_panel:set_bottom(self.teammates:h())

		if is_player then
			teammate_panel:child("revive_panel2"):set_visible(NepgearsyHUDReborn:GetOption("EnableDownCounter"))
			teammate_panel:child("subpanel_bg"):set_h(90)
			teammate_panel:child("subpanel_bg"):set_y(30)

			name:set_left(self.Avatar:left())
			name:set_top(teammate_panel:top() + 9)
			--player_level:set_top(teammate_panel:top() + 9)
			--player_level:set_right(self._panel:right())
			player_name_bg:set_visible(true)
			player_name_bg:set_y(8)
			managers.hud:make_fine_text(name)

			self._player_panel:set_h(teammate_panel:h())
			self._radial_health_panel:set_bottom(teammate_panel:h() - 11)
			self._condition_icon:set_shape(self._radial_health_panel:shape())
			teammate_panel:child("condition_timer"):set_shape(self._radial_health_panel:shape())
			interact_panel:set_shape(self._radial_health_panel:shape())

			if NepgearsyHUDReborn:GetOption("EnableSteamAvatars") then
				weapons_panel:set_bottom(self._radial_health_panel:bottom())
				weapons_panel:set_x(self._radial_health_panel:right() + 4)
				deployable_equipment_panel:set_top(weapons_panel:top())
				deployable_equipment_panel:set_left(weapons_panel:right() + 2)
				cable_ties_panel:set_top(deployable_equipment_panel:bottom() + 1)
				cable_ties_panel:set_left(weapons_panel:right() + 2)
				if PlayerBase.USE_GRENADES then
					grenades_panel:set_left(weapons_panel:right() + 2)
				end
				teammate_panel:child("revive_panel2"):set_x(self._radial_health_panel:left() + 44)
				teammate_panel:child("revive_panel2"):set_y(self._radial_health_panel:top() - 13)
			else
				weapons_panel:set_bottom(self._radial_health_panel:bottom())
				deployable_equipment_panel:set_top(weapons_panel:top())
				cable_ties_panel:set_top(deployable_equipment_panel:bottom() + 1)
				teammate_panel:child("revive_panel2"):set_x(self._radial_health_panel:left() + 60)
				teammate_panel:child("revive_panel2"):set_y(self._radial_health_panel:top() - 8)
			end

			if PlayerBase.USE_GRENADES then
				grenades_panel:set_top(cable_ties_panel:bottom() + 1)
			end

			self.BGAvatar:set_bottom(self._radial_health_panel:bottom() - 2)
			self.Avatar:set_bottom(self.BGAvatar:bottom() - 2)
			self.Avatar:set_left(self.BGAvatar:left() + 2)

			if NepgearsyHUDReborn:GetOption("EnablePlayerLevel") then
				self:set_level()
			end
		else
			self._is_ai = true
			teammate_panel:child("revive_panel2"):set_visible(false)
			teammate_panel:child("subpanel_bg"):set_h(35)
			teammate_panel:child("subpanel_bg"):set_y(115)

			--player_name_bg:set_visible(false)
			player_name_bg:set_bottom(teammate_panel:h() - 6)
			name:set_bottom(teammate_panel:h() - 6)
			name:set_x(5)

			player_level:set_visible(false)
			self.Avatar:set_visible(false)
			self.BGAvatar:set_visible(false)
			self._condition_icon:set_bottom(name:bottom())
			self._condition_icon:set_left(name:right() + 30)
			teammate_panel:child("condition_timer"):set_shape(self._condition_icon:shape())
			teammate_panel:child("subpanel_bg"):set_image("NepgearsyHUDReborn/HUD/Teammate")
		end
	end

	function HUDTeammate:set_callsign(id)
		local teammate_panel = self._panel
		local name = teammate_panel:child("name")
		local level = teammate_panel:child("level")
		local callsign = teammate_panel:child("callsign")

		local peer_color = tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]

		name:set_color(peer_color)
		level:set_color(peer_color)
		callsign:set_color(peer_color)

		if NepgearsyHUDReborn:GetOption("EnableHPSMeter") and self._hps_meter then
			self._hps_meter:set_color(peer_color)
		end

		if NepgearsyHUDReborn:GetOption("ColorWithSkinPanels") then
			teammate_panel:child("subpanel_bg"):set_color(peer_color)
		end

		teammate_panel:child("player_name_bg"):set_color(peer_color)
		self.BGAvatar:set_color(peer_color)
	end

	NepHook:Post(HUDTeammate, "set_name", function(self, teammate_name)
		self._panel:child("name"):set_text(teammate_name)
	end)

	function HUDTeammate:set_level()
		local user_id = self:GetAccountIDByPeer()
		local panel = self._panel:child("level")
		panel:set_visible(true)

		if not user_id or user_id == 0 or user_id == "" then
			NepgearsyHUDReborn:Error("HUDTeammate:set_level - no uid for panel number " .. self._id)
			return
		end

		local infamy = ""
		if not self._main_player then
			local peer_data = managers.network:session():peer_by_user_id(user_id)
			if peer_data:rank() > 0 then
				infamy = managers.experience:rank_string(peer_data:rank()) .. "-"
			end

			local level = peer_data:level()
			if level then
				panel:set_text(infamy .. level)
			end
			--managers.hud:make_fine_text(panel)
		else
			if managers.experience:current_rank() > 0 then
				infamy = managers.experience:rank_string(managers.experience:current_rank()) .. "-"
			end

			panel:set_text(infamy .. managers.experience:current_level())
			--managers.hud:make_fine_text(panel)
		end
	end

	if NepgearsyHUDReborn:GetOption("StatusNumberType") == 1 or NepgearsyHUDReborn:GetOption("StatusNumberType") == 3 then
		NepHook:Post(HUDTeammate, "set_health", function(self, data)
			local health = math.floor(data.current * 10)
			local HealthNumber = self._radial_health_panel:child("HealthNumber")
			HealthNumber:set_text(health)
		end)
	end

	NepHook:Post(HUDTeammate, "set_armor", function(self, data)
		local armor = math.floor(data.current * 10)
		if NepgearsyHUDReborn:GetOption("StatusNumberType") == 2 then
			local ArmorNumber = self._radial_health_panel:child("HealthNumber")
			ArmorNumber:set_text(armor)
		elseif NepgearsyHUDReborn:GetOption("StatusNumberType") == 3 then
			local ArmorNumber = self._radial_health_panel:child("ArmorNumber")
			ArmorNumber:set_text(armor)
		end
	end)

	NepHook:Post(HUDTeammate, "layout_special_equipments", function(self)
		local teammate_panel = self._panel
		local special_equipment = self._special_equipment
		local container_width = teammate_panel:w()
		local row_width = math.floor(container_width / 32)

		for i, panel in ipairs(special_equipment) do
			local zi = i - 1
			local y_pos = -math.floor(zi / row_width) * panel:h() - 23

			panel:set_x(container_width - (panel:w() + 0) * (zi % row_width + 1))
			panel:set_y(y_pos)
		end
	end)

	NepHook:Post(HUDTeammate, "add_special_equipment", function(self, data)
		local teammate_panel = self._panel
		local panel = teammate_panel:child(data.id)
		local special_bitmap = panel:child("bitmap")
		local id = self:peer_id() or managers.network:session():local_peer():id() or 1

		special_bitmap:set_color(tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors])
	end)

	function HUDTeammate:teammate_progress(enabled, tweak_data_id, timer, success)
		self._player_panel:child("radial_health_panel"):set_alpha(enabled and 0.2 or 1)
		self._player_panel:child("interact_panel"):stop()
		self._player_panel:child("interact_panel"):set_visible(enabled)

		if enabled then
			self._player_panel:child("interact_panel"):animate( callback(HUDManager, HUDManager, "_animate_label_interact"), self._interact, timer)
		end
	end

	NepHook:Post(HUDTeammate, "set_ammo_amount_by_type", function(self, type, max_clip, current_clip, current_left, max, weapon_panel)
		local weapon_panel = weapon_panel or self._player_panel:child("weapons_panel"):child(type .. "_weapon_panel")
		local ammo_clip = weapon_panel:child("ammo_clip")

		-- if self._alt_ammo works too
		if NepgearsyHUDReborn:GetOption("EnableRealAmmo") then
			current_left = math.max(0, current_left - max_clip - (current_clip - max_clip))
		end

		ammo_clip:set_text(tostring(current_clip))
		ammo_clip:set_font_size(string.len(current_clip) < 4 and 30 or 22)

		local ammo_total = weapon_panel:child("ammo_total")
		ammo_total:set_text(" / " .. tostring(current_left))
		ammo_total:set_range_color(0, 1, Color(0.8, 0.8, 0.8))
		ammo_total:set_font_size(string.len(current_left) < 4 and 20 or 16)
	end)

	function HUDTeammate:GetAccountIDByPeer()
		if self._main_player then
			return Steam:userid()
		end

		local peer = self:peer_id() or managers.network:session():local_peer():id()
		local steam_id = managers.network:session():peer(peer):user_id()

		return steam_id
	end

	if NepgearsyHUDReborn:GetOption("EnableSteamAvatars") then
		function HUDTeammate:SetupAccountAvatar(refresh)
			local peer = managers.network:session():peer(self._peer_id)
			local steam_id = self._main_player and Steam:userid() or (peer and peer:account_id())
			local quality = self._main_player and Steam.LARGE_AVATAR or 1
			self.Avatar:set_visible(true)
			NepgearsyHUDReborn:SteamAvatar(steam_id, function(texture)
				if texture then
					self.Avatar:set_image(texture)
					self.BGAvatar:set_visible(true)
				end
			end, { quality = quality, refresh = refresh })
		end

		NepHook:Post(HUDTeammate, "set_peer_id", function(self)
			if not self._main_player then
				local peer = managers.network:session():peer(self._peer_id)
				if peer then
					self:SetupAccountAvatar(true)
				end
			end
		end)
	end

	function HUDTeammate:_create_carry(carry_panel)
		self._carry_panel = carry_panel
		local tabs_texture = "guis/textures/pd2/hud_tabs"
		local bg_color = Color.white / 3
		local bag_rect = {
			32,
			33,
			32,
			31
		}
		local bg_rect = {
			84,
			0,
			44,
			32
		}
		local bag_w = 24
		local bag_h = 23

		carry_panel:set_center_x(self._radial_health_panel:center_x())
		carry_panel:bitmap({
			name = "bg",
			visible = false,
			w = 100,
			layer = 0,
			y = 0,
			x = 0,
			texture = tabs_texture,
			texture_rect = bg_rect,
			color = bg_color,
			h = carry_panel:h()
		})
		carry_panel:bitmap({
			name = "bag",
			layer = 0,
			y = 1,
			visible = true,
			x = 1,
			texture = tabs_texture,
			w = bag_w,
			h = bag_h,
			texture_rect = bag_rect,
			color = Color.white
		})
		carry_panel:text({
			y = 0,
			vertical = "center",
			name = "value",
			text = "",
			font = "fonts/font_small_mf",
			visible = false,
			layer = 0,
			color = Color.white,
			x = bag_rect[3] + 4,
			font_size = tweak_data.hud.small_font_size
		})
	end

	if NepgearsyHUDReborn:GetOption("EnableHPSMeter") then
		function HUDTeammate:update_hps_meter(current_hps, total_hps)
			if not self._hps_meter then
				return
			end

			if (NepgearsyHUDReborn:GetOption("ShowHPSCurrent") and current_hps and current_hps > 0) or (NepgearsyHUDReborn:GetOption("ShowHPSTotal") and total_hps and total_hps > 0) then
				local hps_string = nil
				if NepgearsyHUDReborn:GetOption("ShowHPSCurrent") then
					hps_string = (current_hps and current_hps > 0 and string.format("%.2f", current_hps) or "-")
				end
				if NepgearsyHUDReborn:GetOption("ShowHPSTotal") then
					hps_string = (hps_string .. " / ") .. string.format("%.2f", total_hps or 0)
				end
				self._hps_meter:set_text(hps_string)
				self._hps_meter:set_visible(true)
				self._panel:child("name"):set_visible(false)
			else
				self._hps_meter:set_visible(false)
				self._panel:child("name"):set_visible(true)
			end
		end

		function HUDTeammate:change_health(change_of_health)
			if not managers.player then
				return
			end

			change_of_health = change_of_health or 0
			local time_current = managers.player:player_timer():time()
			local passed_time = time_current - (self._last_time or time_current)
			self._total_hps_time = (self._total_hps_time or 0) + passed_time
			self._total_hps_heal = (self._total_hps_heal or 0) + change_of_health
			self._total_hps = self._total_hps_heal / self._total_hps_time

			if time_current > (self._last_heal_happened or 0) + (NepgearsyHUDReborn:GetOption("CurrentHPSTimeout") or 5) then
				self._current_hps_heal = nil
				self._current_hps_time = nil
			end

			self._current_hps_time = (self._current_hps_time or 0) + passed_time
			self._current_hps_heal = (self._current_hps_heal or 0) + change_of_health
			self._current_hps = self._current_hps_heal / self._current_hps_time

			self._last_time = time_current
			if change_of_health > 0 then
				self._last_heal_happened = time_current
			end

			if time_current > (self._last_hps_shown or 0) + (NepgearsyHUDReborn:GetOption("HPSRefreshRate") or 1) then
				self._last_hps_shown = time_current
				self:update_hps_meter(self._current_hps, self._total_hps)
			end
		end
	end

	-- Unlike ovk, I do use player_panel.
	NepHook:Post(HUDTeammate, "_create_equipment_panels", function(self, player_panel)
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

	local revive_colors = {
		Color(255, 255, 44, 44) / 255,
		Color(255, 255, 144, 144) / 255,
		Color(255, 255, 235, 235) / 255,
		Color(255, 255, 255, 255) / 255
	}

	function HUDTeammate:set_revives_amount(revive_amount)
		if revive_amount then
			local revive_panel = self._panel:child("revive_panel2")
			local revive_amount_text = revive_panel:child("revive_amt")
			local revive_icon = revive_panel:child("revive_icon")

			if revive_amount_text then
				revive_amount_text:set_text(tostring(math.max(revive_amount - 1, 0)))
			end
			if revive_icon then
				revive_icon:set_color(revive_colors[revive_amount] or revive_colors[4])
			end
		end
	end

	function HUDTeammate:_update_player_bg(texture)
		if self._main_player then
			return
		end

		if texture then
			self._panel:child("subpanel_bg"):set_image(texture)
		end
	end

	function HUDTeammate:set_copr_indicator(enabled, static_damage_ratio)
		--local teammate_panel = self._panel:child("player")
		local radial_health_panel = self._radial_health_panel
		local copr_overlay_panel = radial_health_panel:child("copr_overlay_panel")
		local radial_health = radial_health_panel:child("radial_health")
		local red = radial_health:color().r

		if alive(copr_overlay_panel) then
			copr_overlay_panel:clear()
			copr_overlay_panel:set_visible(enabled)

			if enabled then
				local num_notches = math.ceil(1 / static_damage_ratio)
				local cx, cy = copr_overlay_panel:center()
				local v1 = Vector3()
				local v2 = Vector3()
				local v3 = Vector3()
				local mset = mvector3.set_static
				local w = 5

				local radius
				local scale
				if NepgearsyHUDReborn:GetOption("HealthStyle") == 1 then
					radius = 24.2
					scale = 11
				else
					radius = 21.5
					scale = 7
				end
				local h = math.min(copr_overlay_panel:w(), copr_overlay_panel:h()) / scale

				for i = 0, num_notches - 1 do
					local rotation = i / num_notches * 360
					local x = cx + math.sin(rotation) * radius
					local y = cy - math.cos(rotation) * radius

					mset(v1, 0, h, 0)
					mset(v2, w, h, 0)
					mset(v3, w / 2, 0, 0)

					local notch = copr_overlay_panel:polygon({
						layer = 0,
						name = tostring(i),
						color = Color.black:with_alpha(0.6),
						rotation = rotation,
						triangles = {
							v1,
							v2,
							v3
						},
						w = w,
						h = h
					})
					notch:script().red = 1 - i / num_notches

					notch:set_visible(notch:script().red <= red + 0.01)
					notch:set_center(x, y)
				end
			end
		end
	end
--[[
else
	NepHook:Post(HUDTeammate, "init", function(self, i, teammates_panel, is_player, width)
		self:_apply_nepgearsy_hud_reborn(i, teammates_panel, is_player, width)
	end)

	function HUDTeammate:_apply_nepgearsy_hud_reborn(i, teammates_panel, is_player, width)
		
	end

	NepHook:Post(HUDTeammate, "set_state", function(self, state)
		local is_player = state == "player"
		local teammate_panel = self._panel
		local name = self._panel:child("name")

		if is_player then
			teammate_panel:set_h(135)
			name:configure({
				vertical = "center",
				layer = 1,
				font = player_font,
				font_size = tweak_data.hud_players.name_size,
				y = 0,
				x = 0
			})
			managers.hud:make_fine_text(name)
		else
			teammate_panel:set_h(135)
			name:configure({
				vertical = "center",
				layer = 1,
				font = player_font,
				font_size = tweak_data.hud_players.name_size,
				y = 0,
				x = 0
			})
			managers.hud:make_fine_text(name)
		end

	end)
]]
end