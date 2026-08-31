if NepgearsyHUDReborn:GetOption("EnableStarring") or NepgearsyHUDReborn:GetOption("ShowMapStarring") then
	NepHook:Post(HUDBlackScreen, "init", function(self)
		--[[
		local function make_fine_text(text)
			local x, y, w, h = text:text_rect()
			text:set_size(w, h)
			text:set_position(math.round(text:x()), math.round(text:y()))

			return x, y, w, h
		end
		]]

		local bs_panel = self._blackscreen_panel -- bullshit panel XD

		if NepgearsyHUDReborn:GetOption("ShowMapStarring") then
			local stage_data = managers.job:current_stage_data()
			local level_data = managers.job:current_level_data()

			local name_id = stage_data and stage_data.name_id or level_data and level_data.name_id
			if name_id then --and not (managers.crime_spree and managers.crime_spree:is_active())
				local heist_panel_text = bs_panel:text({
					name = "heist_panel_text",
					text = managers.localization:to_upper_text(name_id),
					font = tweak_data.menu.pd2_large_font,
					font_size = tweak_data.menu.pd2_small_large_size,
					vertical = "center",
					align = "center",
					valign = {
						0.4,
						0
					},
					w = bs_panel:w(),
					y = -200,
					color = Color.white
				})

				if Global.game_settings.one_down then
					local od_text = bs_panel:text({
						name = "od_text",
						text = managers.localization:to_upper_text("menu_one_down"),
						font = tweak_data.menu.pd2_large_font,
						font_size = 24,
						vertical = "center",
						align = "center",
						valign = {
							0.4,
							0
						},
						w = bs_panel:w(),
						y = heist_panel_text:y() + 35,
						color = Color.red
					})
				end
				--[[
				local narr_tweak = tweak_data.narrative.jobs[Global.level_data.level_id]
				if narr_tweak and narr_tweak.contract_visuals and narr_tweak.contract_visuals.preview_image then
					local data = narr_tweak.contract_visuals.preview_image
					local path, rect = nil

					if data.id then
						path = "guis/dlcs/" .. (data.folder or "bro") .. "/textures/pd2/crimenet/" .. data.id
						rect = data.rect
					elseif data.icon then
						path, rect = tweak_data.hud_icons:get_icon_data(data.icon)
					end

					local bs_heist_icon = bs_panel:bitmap({
						texture = path,
						texture_rect = rect,
						w = 300,
						layer = 0,
						h = 150,
						alpha = 0.4
					})
					bs_heist_icon:set_world_center_x(heist_panel_text:world_center_x())
					bs_heist_icon:set_world_center_y(heist_panel_text:world_center_y() * 2.75)
				end
				]]
			end

			if NepgearsyHUDReborn:GetOption("ShowMapTexture") then
				local job_data = managers.job:current_job_data()
				local level_tweak = tweak_data.levels[Global.level_data.level_id] or {}
				local bg_texture = level_data and level_data.load_screen or level_tweak and level_tweak.load_screen or level_tweak and level_tweak.load_data and level_tweak.load_data.image or job_data and job_data.load_screen
				if bg_texture then
					bs_panel:bitmap({
						texture = bg_texture,
						w = bs_panel:w(),
						h = bs_panel:h(),
						alpha = 0.25,
						layer = -1
					})
				end
			end
		end

		if NepgearsyHUDReborn:GetOption("EnableStarring") then
			local starring_panel = bs_panel:panel({
				name = "starring_panel",
				visible = true,
				vertical = "left",
				align = "left"
			})

			local starring_with = starring_panel:text({
				name = "starring_with",
				text = "STARRING",
				font = tweak_data.menu.pd2_large_font,
				font_size = 30,
				vertical = "left",
				align = "left",
				valign = {
					0.4, 
					0
				},
				color = Color(1, 0.7, 0)
			})

			local start_y = starring_panel:y() + 30
			local avatar_size = 40
			for i = 1, tweak_data.max_players or 4 do
				local avatar = starring_panel:bitmap({
					name = "avatar_player_" .. i,
					w = avatar_size,
					h = avatar_size,
					texture = "guis/textures/pd2/none_icon",
					visible = false
				})
				avatar:set_top(start_y + (i - 1) * 45)

				local player_text = starring_panel:text({
					name = "player_" .. i,
					text = "",
					font = tweak_data.menu.pd2_large_font,
					font_size = 24,
					vertical = "left",
					align = "left",
					valign = {
						0.4,
						0
					},
					x = avatar:x() + 50,
					y = avatar:y() + 10,
					color = Color.white,
					visible = false
				})
			end
		end
	end)
end
