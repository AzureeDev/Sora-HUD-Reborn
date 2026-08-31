if NepgearsyHUDReborn:GetOption("EnableHorizontalLoadout") then
	NepHook:Post(TeamLoadoutItem, "init", function(self)
		local quarter_height = self._panel:h() / #self._player_slots
		for i, slot in ipairs(self._player_slots) do
			local panel = slot.panel
			panel:set_x(0)
			panel:set_y((i - 1) * quarter_height)
			panel:set_w(self._panel:w())
			panel:set_h(quarter_height)
		end
	end)

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
		local aspect = nil
		local x = player_slot.panel:w() / 18
		local y = player_slot.panel:h() / 2
		local h = slot_h * 0.75
		local w = h
		local slot_color = tweak_data.chat_colors[slot] or tweak_data.chat_colors[#tweak_data.chat_colors]

		local text = "menu_" .. tostring(criminal_name)
		if NepgearsyHUDReborn:GetOption("HorizontalPerkDeck") then
			if outfit and outfit.skills and outfit.skills.specializations then
				local spec = tonumber(outfit.skills.specializations[1])

				if spec and spec <= #tweak_data.skilltree.specializations then
					text = "menu_st_spec_" .. tostring(spec)
				end
			end
		end

		local criminal_text = player_slot.panel:text({
			y = 5,
			x = 5,
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = slot_color,
			text = managers.localization:to_upper_text(text)
		})

		if outfit.primary.factory_id then
			local primary_id = managers.weapon_factory:get_weapon_id_by_factory_id(outfit.primary.factory_id)
			local texture, rarity = managers.blackmarket:get_weapon_icon_path(primary_id, outfit.primary.cosmetics)
			local primary_bitmap = player_slot.panel:bitmap({
				alpha = 0.8,
				layer = 1,
				texture = texture,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5
			})
			aspect = primary_bitmap:texture_width() / math.max(1, primary_bitmap:texture_height())
			primary_bitmap:set_w(primary_bitmap:h() * aspect)
			primary_bitmap:set_center_x(x * 2.5)
			primary_bitmap:set_center_y(y)

			if rarity then
				local rarity_bitmap = player_slot.panel:bitmap({
					blend_mode = "add",
					rotation = 360,
					texture = rarity
				})
				local texture_width = rarity_bitmap:texture_width()
				local texture_height = rarity_bitmap:texture_height()
				local panel_width = h * aspect
				local panel_height = h
				local tw = texture_width
				local th = texture_height
				local pw = panel_width
				local ph = panel_height

				if tw == 0 or th == 0 then
					Application:error("[TeamLoadoutItem] BG Texture size error!:", "width", tw, "height", th)
					tw = 1
					th = 1
				end

				local sw = math.min(pw, ph * tw / th)
				local sh = math.min(ph, pw / (tw / th))

				rarity_bitmap:set_size(math.round(sw), math.round(sh))
				rarity_bitmap:set_center(primary_bitmap:center())
			end

			local perk_index = 0
			local perks = managers.blackmarket:get_perks_from_weapon_blueprint(outfit.primary.factory_id, outfit.primary.blueprint)

			if table.size(perks) > 0 then
				for perk in pairs(perks) do
					if perk ~= "bonus" then
						local texture = "guis/textures/pd2/blackmarket/inv_mod_" .. perk

						if DB:has(Idstring("texture"), texture) then
							local perk_object = player_slot.panel:bitmap({
								alpha = 0.8,
								h = 16,
								w = 16,
								layer = 2,
								texture = texture,
								rotation = math.random(2) - 1.5
							})

							perk_object:set_rightbottom(math.round(primary_bitmap:right() - perk_index * 16), math.round(primary_bitmap:bottom() - 5))

							perk_index = perk_index + 1
						end
					end
				end
			end

			local factory = tweak_data.weapon.factory.parts
			local parts = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("bonus", outfit.primary.factory_id, outfit.primary.blueprint) or {}
			local stats, custom_stats, has_stat, has_team = nil
			local textures = {}

			for _, part_id in ipairs(parts) do
				stats = factory[part_id] and factory[part_id].stats or false
				custom_stats = factory[part_id] and factory[part_id].custom_stats or false
				has_stat = stats and table.size(stats) > 1 and true or false

				if custom_stats and (custom_stats.exp_multiplier or custom_stats.money_multiplier) then
					has_team = true
				else
					has_team = false
				end

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
				has_team = bonus_data and (bonus_data.exp_multiplier or bonus_data.money_multiplier) and true or false

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
						alpha = 0.8,
						h = 16,
						w = 16,
						layer = 2,
						texture = texture,
						rotation = math.random(2) - 1.5
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
				alpha = 0.8,
				layer = 1,
				texture = texture,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5
			})
			aspect = secondary_bitmap:texture_width() / math.max(1, secondary_bitmap:texture_height())

			secondary_bitmap:set_w(secondary_bitmap:h() * aspect)
			secondary_bitmap:set_center_x(x * 5.5)
			secondary_bitmap:set_center_y(y)

			if rarity then
				local rarity_bitmap = player_slot.panel:bitmap({
					blend_mode = "add",
					rotation = 360,
					texture = rarity
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

				local sw = math.min(pw, ph * tw / th)
				local sh = math.min(ph, pw / (tw / th))

				rarity_bitmap:set_size(math.round(sw), math.round(sh))
				rarity_bitmap:set_center(secondary_bitmap:center())
			end

			local perk_index = 0
			local perks = managers.blackmarket:get_perks_from_weapon_blueprint(outfit.secondary.factory_id, outfit.secondary.blueprint)

			if table.size(perks) > 0 then
				for perk in pairs(perks) do
					if perk ~= "bonus" then
						local texture = "guis/textures/pd2/blackmarket/inv_mod_" .. perk

						if DB:has(Idstring("texture"), texture) then
							local perk_object = player_slot.panel:bitmap({
								alpha = 0.8,
								h = 16,
								w = 16,
								layer = 2,
								texture = texture,
								rotation = math.random(2) - 1.5
							})

							perk_object:set_rightbottom(secondary_bitmap:right() - perk_index * 16, secondary_bitmap:bottom() - 5)

							perk_index = perk_index + 1
						end
					end
				end
			end

			local factory = tweak_data.weapon.factory.parts
			local parts = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("bonus", outfit.secondary.factory_id, outfit.secondary.blueprint) or {}
			local stats, custom_stats, has_stat, has_team = nil
			local textures = {}

			for _, part_id in ipairs(parts) do
				stats = factory[part_id] and factory[part_id].stats or false
				custom_stats = factory[part_id] and factory[part_id].custom_stats or false
				has_stat = stats and table.size(stats) > 1 and true or false

				if custom_stats and (custom_stats.exp_multiplier or custom_stats.money_multiplier) then
					has_team = true
				else
					has_team = false
				end

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
				has_team = bonus_data and (bonus_data.exp_multiplier or bonus_data.money_multiplier) and true or false

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
						alpha = 0.8,
						h = 16,
						w = 16,
						layer = 2,
						texture = texture,
						rotation = math.random(2) - 1.5
					})

					perk_object:set_rightbottom(math.round(secondary_bitmap:right() - perk_index * 16), math.round(secondary_bitmap:bottom() - 5))

					perk_index = perk_index + 1
				end
			end
		end

		if outfit.melee_weapon then
			local texture = managers.blackmarket:get_melee_weapon_icon(outfit.melee_weapon)
			local melee_weapon_bitmap = player_slot.panel:bitmap({
				alpha = 0.8,
				w = w,
				h = h,
				texture = texture,
				rotation = math.random(2) - 1.5
			})
			aspect = melee_weapon_bitmap:texture_width() / math.max(1, melee_weapon_bitmap:texture_height())

			melee_weapon_bitmap:set_w(melee_weapon_bitmap:h() * aspect)
			melee_weapon_bitmap:set_center_x(x * 8.7)
			melee_weapon_bitmap:set_center_y(y)

			local icon_list = managers.menu_component:create_melee_status_icon_list(outfit.melee_weapon)
			local icon_index = 0

			for _, texture in ipairs(icon_list) do
				if DB:has(Idstring("texture"), texture) then
					local status_object = player_slot.panel:bitmap({
						alpha = 0.8,
						h = 16,
						w = 16,
						layer = 2,
						texture = texture,
						rotation = math.random(2) - 1.5
					})

					status_object:set_rightbottom(melee_weapon_bitmap:right() - icon_index * 16, melee_weapon_bitmap:bottom() - 5)

					icon_index = icon_index + 1
				end
			end
		end

		if outfit.grenade then
			local texture = managers.blackmarket:get_throwable_icon(outfit.grenade)
			local grenade_bitmap = player_slot.panel:bitmap({
				alpha = 0.8,
				w = w * 0.9,
				h = h * 0.9,
				texture = texture,
				rotation = math.random(2) - 1.5
			})
			aspect = grenade_bitmap:texture_width() / math.max(1, grenade_bitmap:texture_height())

			grenade_bitmap:set_w(grenade_bitmap:h() * aspect)
			grenade_bitmap:set_center_x(x * 11.5)
			grenade_bitmap:set_center_y(y)
		else
			local grenade_bitmap = player_slot.panel:bitmap({
				texture = "guis/textures/pd2/none_icon",
				alpha = 0.8,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5
			})
			aspect = grenade_bitmap:texture_width() / math.max(1, grenade_bitmap:texture_height())

			grenade_bitmap:set_w(grenade_bitmap:h() * aspect)
			grenade_bitmap:set_center_x(x * 11.5)
			grenade_bitmap:set_center_y(y)
		end

		if outfit.armor then
			local texture = managers.blackmarket:get_armor_icon(outfit.armor)
			local armor_bitmap = player_slot.panel:bitmap({
				alpha = 0.8,
				w = w,
				h = h,
				texture = texture,
				rotation = math.random(2) - 1.5
			})
			aspect = armor_bitmap:texture_width() / math.max(1, armor_bitmap:texture_height())

			armor_bitmap:set_w(armor_bitmap:h() * aspect)
			armor_bitmap:set_center_x(x * 13.75)
			armor_bitmap:set_center_y(y)
		end

		if outfit.deployable and outfit.deployable ~= "nil" then
			local texture = managers.blackmarket:get_deployable_icon(outfit.deployable)
			local deployable_bitmap = player_slot.panel:bitmap({
				alpha = 0.8,
				w = w,
				h = h,
				texture = texture,
				rotation = math.random(2) - 1.5
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

				if outfit.secondary_deployable then
					deployable_text:set_right(deployable_bitmap:center())
				end
			end

			if outfit.secondary_deployable then
				local secondary_texture = managers.blackmarket:get_deployable_icon(outfit.secondary_deployable)
				local secondary_deployable_bitmap = player_slot.panel:bitmap({
					alpha = 0.8,
					w = w,
					h = h,
					texture = secondary_texture,
					rotation = math.random(2) - 1.5
				})
				aspect = secondary_deployable_bitmap:texture_width() / math.max(1, secondary_deployable_bitmap:texture_height())

				secondary_deployable_bitmap:set_w(secondary_deployable_bitmap:h() * aspect)
				secondary_deployable_bitmap:set_center_x(x * 16.8)
				secondary_deployable_bitmap:set_center_y(y)
				deployable_bitmap:set_center_x(x * 15.3)

				local secondary_deployable_amount = tonumber(outfit.secondary_deployable_amount) or 0

				if secondary_deployable_amount > 1 then
					local deployable_text = player_slot.panel:text({
						text = "x" .. tostring(secondary_deployable_amount),
						font_size = tweak_data.menu.pd2_small_font_size,
						font = tweak_data.menu.pd2_small_font,
						rotation = deployable_bitmap:rotation(),
						color = tweak_data.screen_colors.text
					})
					local _, _, w, h = deployable_text:text_rect()

					deployable_text:set_size(w, h)
					deployable_text:set_rightbottom(player_slot.panel:w(), player_slot.panel:h())
					deployable_text:set_position(math.round(deployable_text:x()) - 10, math.round(deployable_text:y()) - 5)
				end
			end
		else
			local deployable_bitmap = player_slot.panel:bitmap({
				texture = "guis/textures/pd2/none_icon",
				alpha = 0.8,
				w = w,
				h = h,
				rotation = math.random(2) - 1.5
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