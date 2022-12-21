--[[local function make_fine_text(text)
	local x, y, w, h = text:text_rect()

	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))

	return x, y, w, h
end

local large_font = tweak_data.menu.pd2_large_font

NepHook:Post(HUDStageEndScreen, "init", function(self, hud, workspace)
    self:_hide_original_elements()

    self._end_game_data = {
        heist_name = managers.skirmish:is_skirmish() and (managers.skirmish:is_weekly_skirmish() and managers.localization:to_upper_text("menu_weekly_skirmish") or managers.localization:to_upper_text("menu_skirmish")) or managers.job:current_level_id() and managers.localization:to_upper_text(tweak_data.levels[managers.job:current_level_id()].name_id) or "",
        heist_difficulty = Global.game_settings.difficulty or "Easy",
		is_singleplayer = Global.game_settings.single_player
    }

	self:_init_new_transition(workspace)
end)

function HUDStageEndScreen:_is_success()
    return game_state_machine:current_state().is_success and game_state_machine:current_state():is_success()
end

function HUDStageEndScreen:_hide_original_elements()
	self._backdrop:hide()
end

function HUDStageEndScreen:_init_new_transition(workspace)
	self._new_panel = workspace:panel():panel({
		valign = "grow",
		name = "ws_v2",
		layer = 0,
		halign = "grow"
	})

	local hello = self._new_panel:text({
		text = "Hello!",
		font = large_font,
		font_size = 20,
		color = Color.white
	})
end]]--
