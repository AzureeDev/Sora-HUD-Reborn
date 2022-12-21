function ElementTerminateAssault:on_executed(instigator)
	local state = managers.groupai:state()

	if state.terminate_assaults then
		state:terminate_assaults()
		managers.hud:hide_panels("assault_panel")
    end

    local assault_corner = managers.hud._hud_assault_corner
    
    assault_corner:_update_assault_hud_color(Color.white)
    assault_corner:_start_slow_assault({
        "NepgearsyHUDReborn/HUD/AssaultCorner/Uno1",
        "hud_assault_end_line",
        "NepgearsyHUDReborn/HUD/AssaultCorner/Uno2",
        "hud_assault_end_line",
        "NepgearsyHUDReborn/HUD/AssaultCorner/Uno3",
        "hud_assault_end_line",
        "NepgearsyHUDReborn/HUD/AssaultCorner/Uno4",
        "hud_assault_end_line",
        "NepgearsyHUDReborn/HUD/AssaultCorner/Uno5",
        "hud_assault_end_line",
        "NepgearsyHUDReborn/HUD/AssaultCorner/Uno6",
        "hud_assault_end_line"
    })

    managers.hud:hide_panels_real_slow("assault_panel_v2", "trackerPanel", "hostages_panel")

	ElementTerminateAssault.super.on_executed(self, instigator)
end