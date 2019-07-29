if NepgearsyHUDReborn:GetOption("EnableHorizontalLoadout") then
	function TeamLoadoutItem:init(panel, text, i)
		TeamLoadoutItem.super.init(self, panel, text, i)
		self._player_slots = {}
		local quarter_height = self._panel:h() / 4
		local slot_panel
		for i = 1, 4 do
			local old_height = slot_panel and slot_panel:bottom() or 0
			slot_panel = self._panel:panel({
				x = 0,
				y = old_height,
				w = self._panel:w(),
				h = quarter_height,
				halign = "grow"
			})
			self._player_slots[i] = {}
			self._player_slots[i].panel = slot_panel
			self._player_slots[i].outfit = {}
			local kit_menu = managers.menu:get_menu("kit_menu")
			if kit_menu then
				local kit_slot = kit_menu.renderer:get_player_slot_by_peer_id(i)
				if kit_slot then
					local outfit = kit_slot.outfit
					local character = kit_slot.params and kit_slot.params.character
					if outfit and character then
						self:set_slot_outfit(i, character, outfit)
					end
				end
			end
		end
	end

	function TeamLoadoutItem:set_slot_outfit(slot, criminal_name, outfit)
		local player_slot = self._player_slots[slot]
		if not player_slot then
			return
		end
		player_slot.panel:clear()
		if not outfit then
			return
		end
		local slot_h = player_slot.panel:h()
		local aspect
		local x = player_slot.panel:w() / 18
		local y = player_slot.panel:h() / 2
		local w = h
		local h = slot_h * 0.75
		local slot_color = tweak_data.chat_colors[slot]
		local criminal_text = player_slot.panel:text({
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = slot_color,
			x = 5,
			y = 5,
			text = managers.localization:to_upper_text("menu_" .. tostring(criminal_name))
		})
		if SystemInfo:platform() == Idstring("WIN32") then
			criminal_text:move(5, 5)
		end
		local primary_texture, secondary_texture
		if outfit.primary.factory_id then
			local primary_id = managers.weapon_factory:get_weapon_id_by_factory_id(outfit.primary.factory_id)
			local texture, rarity = managers.blackmarket:get_weapon_icon_path(primary_id, outfit.primary.cosmetics)
			local primary_bitmap = player_slot.panel:bitmap({
				texture = texture,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1,
				layer = 1
			})
			aspect = primary_bitmap:texture_width() / math.max(1, primary_bitmap:texture_height())
			primary_bitmap:set_w(primary_bitmap:h() * aspect)
			primary_bitmap:set_center_x(x * 2.5)
			primary_bitmap:set_center_y(y)
			if rarity then
				local rarity_bitmap = player_slot.panel:bitmap({
					texture = rarity,
					rotation = 360,
					blend_mode = "add"
				})
				local texture_width = rarity_bitmap:texture_width()
				local texture_height = rarity_bitmap:texture_height()
				local panel_width = primary_bitmap:w()
				local panel_height = primary_bitmap:h()
				local tw = texture_width
				local th = texture_height
				local pw = panel_width
				local ph = panel_height
				if tw == 0 or th == 0 then
					Application:error("[TeamLoadoutItem] BG Texture size error!:", "width", tw, "height", th)
					tw = 1
					th = 1
				end
				local sw = math.min(pw, ph * (tw / th))
				local sh = math.min(ph, pw / (tw / th))
				rarity_bitmap:set_size(math.round(sw), math.round(sh))
				rarity_bitmap:set_center(primary_bitmap:center())
			end
			primary_texture = texture
			local perk_index = 0
			local perks = managers.blackmarket:get_perks_from_weapon_blueprint(outfit.primary.factory_id, outfit.primary.blueprint)
			if 0 < table.size(perks) then
				for perk in pairs(perks) do
					if perk ~= "bonus" then
						local texture = "guis/textures/pd2/blackmarket/inv_mod_" .. perk
						if DB:has(Idstring("texture"), texture) then
							local perk_object = player_slot.panel:bitmap({
								texture = texture,
								w = 16,
								h = 16,
								rotation = math.random(2) - 1.5,
								alpha = 1,
								layer = 2
							})
							perk_object:set_rightbottom(math.round(primary_bitmap:right() - perk_index * 16), math.round(primary_bitmap:bottom() - 5))
							perk_index = perk_index + 1
						end
					end
				end
			end
			local factory = tweak_data.weapon.factory.parts
			local parts = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("bonus", outfit.primary.factory_id, outfit.primary.blueprint) or {}
			local stats, custom_stats, has_stat, has_team
			local textures = {}
			for _, part_id in ipairs(parts) do
				stats = factory[part_id] and factory[part_id].stats or false
				custom_stats = factory[part_id] and factory[part_id].custom_stats or false
				has_stat = stats and 1 < table.size(stats) and true or false
				has_team = custom_stats and (custom_stats.exp_multiplier or custom_stats.money_multiplier and true) or false
				if has_stat then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_stats")
				end
				if has_team then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_team")
				end
			end
			if #textures == 0 and outfit.primary.cosmetics and outfit.primary.cosmetics.bonus and not managers.job:is_current_job_competitive() then
				local bonus_data = tweak_data.economy.bonuses[tweak_data.blackmarket.weapon_skins[outfit.primary.cosmetics.id].bonus]
				has_stat = bonus_data and bonus_data.stats and true or false
				has_team = bonus_data and (bonus_data.exp_multiplier or bonus_data.money_multiplier and true) or false
				if has_stat then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_stats")
				end
				if has_team then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_team")
				end
			end
			for _, texture in ipairs(table.list_union(textures)) do
				if DB:has(Idstring("texture"), texture) then
					local perk_object = player_slot.panel:bitmap({
						texture = texture,
						w = 16,
						h = 16,
						rotation = math.random(2) - 1.5,
						alpha = 1,
						layer = 2
					})
					perk_object:set_rightbottom(math.round(primary_bitmap:right() - perk_index * 16), math.round(primary_bitmap:bottom() - 5))
					perk_index = perk_index + 1
				end
			end
		end
		if outfit.secondary.factory_id then
			local secondary_id = managers.weapon_factory:get_weapon_id_by_factory_id(outfit.secondary.factory_id)
			local texture, rarity = managers.blackmarket:get_weapon_icon_path(secondary_id, outfit.secondary.cosmetics)
			local secondary_bitmap = player_slot.panel:bitmap({
				texture = texture,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1,
				layer = 1
			})
			aspect = secondary_bitmap:texture_width() / math.max(1, secondary_bitmap:texture_height())
			secondary_bitmap:set_w(secondary_bitmap:h() * aspect)
			secondary_bitmap:set_center_x(x * 5.5)
			secondary_bitmap:set_center_y(y)
			if rarity then
				local rarity_bitmap = player_slot.panel:bitmap({
					texture = rarity,
					rotation = 360,
					blend_mode = "add"
				})
				local texture_width = rarity_bitmap:texture_width()
				local texture_height = rarity_bitmap:texture_height()
				local panel_width = secondary_bitmap:w()
				local panel_height = secondary_bitmap:h()
				local tw = texture_width
				local th = texture_height
				local pw = panel_width
				local ph = panel_height
				if tw == 0 or th == 0 then
					Application:error("[TeamLoadoutItem] BG Texture size error!:", "width", tw, "height", th)
					tw = 1
					th = 1
				end
				local sw = math.min(pw, ph * (tw / th))
				local sh = math.min(ph, pw / (tw / th))
				rarity_bitmap:set_size(math.round(sw), math.round(sh))
				rarity_bitmap:set_center(secondary_bitmap:center())
			end
			secondary_texture = texture
			local perk_index = 0
			local perks = managers.blackmarket:get_perks_from_weapon_blueprint(outfit.secondary.factory_id, outfit.secondary.blueprint)
			if 0 < table.size(perks) then
				for perk in pairs(perks) do
					if perk ~= "bonus" then
						local texture = "guis/textures/pd2/blackmarket/inv_mod_" .. perk
						if DB:has(Idstring("texture"), texture) then
							local perk_object = player_slot.panel:bitmap({
								texture = texture,
								w = 16,
								h = 16,
								rotation = math.random(2) - 1.5,
								alpha = 1,
								layer = 2
							})
							perk_object:set_rightbottom(secondary_bitmap:right() - perk_index * 16, secondary_bitmap:bottom() - 5)
							perk_index = perk_index + 1
						end
					end
				end
			end
			local factory = tweak_data.weapon.factory.parts
			local parts = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("bonus", outfit.secondary.factory_id, outfit.secondary.blueprint) or {}
			local stats, custom_stats, has_stat, has_team
			local textures = {}
			for _, part_id in ipairs(parts) do
				stats = factory[part_id] and factory[part_id].stats or false
				custom_stats = factory[part_id] and factory[part_id].custom_stats or false
				has_stat = stats and 1 < table.size(stats) and true or false
				has_team = custom_stats and (custom_stats.exp_multiplier or custom_stats.money_multiplier and true) or false
				if has_stat then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_stats")
				end
				if has_team then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_team")
				end
			end
			if #textures == 0 and outfit.secondary.cosmetics and outfit.secondary.cosmetics.bonus and not managers.job:is_current_job_competitive() then
				local bonus_data = tweak_data.economy.bonuses[tweak_data.blackmarket.weapon_skins[outfit.secondary.cosmetics.id].bonus]
				has_stat = bonus_data and bonus_data.stats and true or false
				has_team = bonus_data and (bonus_data.exp_multiplier or bonus_data.money_multiplier and true) or false
				if has_stat then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_stats")
				end
				if has_team then
					table.insert(textures, "guis/textures/pd2/blackmarket/inv_mod_bonus_team")
				end
			end
			for _, texture in ipairs(table.list_union(textures)) do
				if DB:has(Idstring("texture"), texture) then
					local perk_object = player_slot.panel:bitmap({
						texture = texture,
						w = 16,
						h = 16,
						rotation = math.random(2) - 1.5,
						alpha = 1,
						layer = 2
					})
					perk_object:set_rightbottom(math.round(secondary_bitmap:right() - perk_index * 16), math.round(secondary_bitmap:bottom() - 5))
					perk_index = perk_index + 1
				end
			end
		end
		if outfit.melee_weapon then
			local guis_catalog = "guis/"
			local bundle_folder = tweak_data.blackmarket.melee_weapons[outfit.melee_weapon] and tweak_data.blackmarket.melee_weapons[outfit.melee_weapon].texture_bundle_folder
			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end
			local melee_weapon_bitmap = player_slot.panel:bitmap({
				texture = guis_catalog .. "textures/pd2/blackmarket/icons/melee_weapons/" .. outfit.melee_weapon,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1
			})
			aspect = melee_weapon_bitmap:texture_width() / math.max(1, melee_weapon_bitmap:texture_height())
			melee_weapon_bitmap:set_w(melee_weapon_bitmap:h() * aspect)
			melee_weapon_bitmap:set_center_x(x * 8.25)
			melee_weapon_bitmap:set_center_y(y)
		end
		if outfit.grenade then
			local guis_catalog = "guis/"
			local bundle_folder = tweak_data.blackmarket.projectiles[outfit.grenade] and tweak_data.blackmarket.projectiles[outfit.grenade].texture_bundle_folder
			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end
			local grenade_bitmap = player_slot.panel:bitmap({
				texture = guis_catalog .. "textures/pd2/blackmarket/icons/grenades/" .. outfit.grenade,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1
			})
			aspect = grenade_bitmap:texture_width() / math.max(1, grenade_bitmap:texture_height())
			grenade_bitmap:set_w(grenade_bitmap:h() * aspect)
			grenade_bitmap:set_center_x(x * 11.5)
			grenade_bitmap:set_center_y(y)
		end
		if outfit.armor then
			local guis_catalog = "guis/"
			local bundle_folder = tweak_data.blackmarket.armors[outfit.armor] and tweak_data.blackmarket.armors[outfit.armor].texture_bundle_folder
			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end
			local armor_bitmap = player_slot.panel:bitmap({
				texture = guis_catalog .. "textures/pd2/blackmarket/icons/armors/" .. outfit.armor,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1
			})
			aspect = armor_bitmap:texture_width() / math.max(1, armor_bitmap:texture_height())
			armor_bitmap:set_w(armor_bitmap:h() * aspect)
			armor_bitmap:set_center_x(x * 13.75)
			armor_bitmap:set_center_y(y)
		end
		if outfit.deployable and outfit.deployable ~= "nil" then
			local guis_catalog = "guis/"
			local bundle_folder = tweak_data.blackmarket.deployables[outfit.deployable] and tweak_data.blackmarket.deployables[outfit.deployable].texture_bundle_folder
			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end
			local deployable_bitmap = player_slot.panel:bitmap({
				texture = guis_catalog .. "textures/pd2/blackmarket/icons/deployables/" .. outfit.deployable,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1
			})
			aspect = deployable_bitmap:texture_width() / math.max(1, deployable_bitmap:texture_height())
			deployable_bitmap:set_w(deployable_bitmap:h() * aspect)
			deployable_bitmap:set_center_x(x * 16)
			deployable_bitmap:set_center_y(y)
			local deployable_amount = tonumber(outfit.deployable_amount) or 0
			if deployable_amount > 1 then
				local deployable_text = player_slot.panel:text({
					text = "x" .. tostring(deployable_amount),
					font_size = tweak_data.menu.pd2_small_font_size,
					font = tweak_data.menu.pd2_small_font,
					rotation = deployable_bitmap:rotation(),
					color = tweak_data.screen_colors.text
				})
				local _, _, w, h = deployable_text:text_rect()
				deployable_text:set_size(w, h)
				deployable_text:set_rightbottom(player_slot.panel:w(), player_slot.panel:h())
				deployable_text:set_position(math.round(deployable_text:x()) - 16, math.round(deployable_text:y()) - 5)
			end
		else
			local deployable_bitmap = player_slot.panel:bitmap({
				texture = "guis/textures/pd2/none_icon",
				w = w,
				h = h,
				rotation = math.random(2) - 1.5,
				alpha = 1
			})
			aspect = deployable_bitmap:texture_width() / math.max(1, deployable_bitmap:texture_height())
			deployable_bitmap:set_w(deployable_bitmap:h() * aspect)
			deployable_bitmap:set_center_x(x * 16)
			deployable_bitmap:set_center_y(y)
		end
		player_slot.box = BoxGuiObject:new(player_slot.panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
	end
end