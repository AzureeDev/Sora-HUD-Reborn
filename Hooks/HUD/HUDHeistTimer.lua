NepHook:Post(HUDHeistTimer, "init", function(self)
    self._heist_timer_panel:set_w(86)
    self._heist_timer_panel:set_h(24)
    self._heist_timer_panel:set_x(0)
    self._heist_timer_panel:set_y(0)
    self._heist_timer_panel:set_valign("right")
    
    if managers.hud._hud_minimap._minimap_enabled then
        self._heist_timer_panel:set_top(managers.hud._hud_minimap._panel:bottom() + 5)
    else
        self._heist_timer_panel:set_top(managers.hud._hud_minimap._panel:bottom())
    end

    self._timer_text = self._heist_timer_panel:text({
		name = "timer_text",
		vertical = "center",
		word_wrap = false,
		wrap = false,
		font_size = 20,
        align = "right",
        x = -10,
		text = "00:00",
        layer = 1,
        y = 1,
		font = "fonts/font_large_mf",
		color = Color.black
	})

    local rect = self._heist_timer_panel:rect({
        name = "background",
        color = Color.white,
        alpha = 0.6,
        layer = -1,
        halign = "scale",
        valign = "scale"
    })

    local TimeR_texture = self._heist_timer_panel:bitmap({
        w = 20,
        h = 20,
        x = 2,
        y = 2,
        texture = "NepgearsyHUDReborn/HUD/TimeR",
        color = Color.black,
        valign = "center"
    })
    --TimeR_texture:set_center_y(self._heist_timer_panel:center_y())

end)