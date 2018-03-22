NepHook:Post( HUDBlackScreen, "init", function(self, hud)

    if not NepgearsyHUDReborn.Options:GetValue("EnableStarring") then
        return
    end
    
	local function make_fine_text(text)
		local x, y, w, h = text:text_rect()

		text:set_size(w, h)
		text:set_position(math.round(text:x()), math.round(text:y()))

		return x, y, w, h
	end
	
	local stage_data = managers.job:current_stage_data()
	local level_data = managers.job:current_level_data()
	local name_id = stage_data and stage_data.name_id or level_data and level_data.name_id or nil
	local bs_panel = self._blackscreen_panel
	local starring_panel = bs_panel:panel({
		name = "starring_panel",
		visible = true,
		vertical = "left",
		align = "left"
	})

	if name_id then
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
				color = Color.red
			})
			od_text:set_y(heist_panel_text:y() + 35)
		end
	end

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

	local avatar_player_1 = starring_panel:bitmap({
		name = "avatar_player_1",
		w = 40,
		h = 40,
		visible = false,
		texture = "guis/textures/pd2/none_icon"
	})
	avatar_player_1:set_top(starring_panel:y() + 30)
	local player_1 = starring_panel:text({
		name = "player_1",
		text = "",
		font = tweak_data.menu.pd2_large_font,
		font_size = 24,
		vertical = "left",
		align = "left",
		valign = {
			0.4,
			0
		},
		color = Color.white,
		visible = false
	})
	player_1:set_x(avatar_player_1:x() + 50)
	player_1:set_y(avatar_player_1:y() + 10)
	
	local avatar_player_2 = starring_panel:bitmap({
		name = "avatar_player_2",
		w = 40,
		h = 40,
		visible = false,
		texture = "guis/textures/pd2/none_icon"
	})
	avatar_player_2:set_top(avatar_player_1:y() + 45)
	local player_2 = starring_panel:text({
		name = "player_2",
		text = "",
		font = tweak_data.menu.pd2_large_font,
		font_size = 24,
		vertical = "left",
		align = "left",
		valign = {
			0.4,
			0
		},
		color = Color.white
	})
	player_2:set_x(avatar_player_2:x() + 50)
	player_2:set_y(avatar_player_2:y() + 10)

	local avatar_player_3 = starring_panel:bitmap({
		name = "avatar_player_3",
		w = 40,
		h = 40,
		visible = false,
		texture = "guis/textures/pd2/none_icon"
	})

	avatar_player_3:set_top(avatar_player_2:y() + 45)
	local player_3 = starring_panel:text({
		name = "player_3",
		text = "",
		font = tweak_data.menu.pd2_large_font,
		font_size = 24,
		vertical = "left",
		align = "left",
		valign = {
			0.4,
			0
		},
		color = Color.white
	})
	player_3:set_x(avatar_player_3:x() + 50)
	player_3:set_y(avatar_player_3:y() + 10)

	local avatar_player_4 = starring_panel:bitmap({
		name = "avatar_player_4",
		w = 40,
		h = 40,
		visible = false,
		texture = "guis/textures/pd2/none_icon"
	})

	avatar_player_4:set_top(avatar_player_3:y() + 45)
	local player_4 = starring_panel:text({
		name = "player_4",
		text = "",
		font = tweak_data.menu.pd2_large_font,
		font_size = 24,
		vertical = "left",
		align = "left",
		valign = {
			0.4,
			0
		},
		color = Color.white
	})
	player_4:set_x(avatar_player_4:x() + 50)
	player_4:set_y(avatar_player_4:y() + 10)

end)