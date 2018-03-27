NepHook:Post(HUDPresenter, "init", function(self, hud)
    --self._hud_panel:child("present_panel"):set_visible(true)
    self._bg_box:set_x(0)

    local icon = self._bg_box:bitmap({
        name = "icon",
        texture = "NepgearsyHUDReborn/HUD/ObjectiveNotificationIcon",
        w = 32,
        h = 32,
        x = 2,
        y = 2
    })
end)

function HUDPresenter:_present_information(params)
	local present_panel = self._hud_panel:child("present_panel")
	local title = self._bg_box:child("title")
    local text = self._bg_box:child("text")
    local icon = self._bg_box:child("icon")
    
    title:set_left(icon:right() + 5)
    text:set_left(icon:right() + 5)

    title:set_font(Idstring("fonts/font_large_mf"))
    text:set_font(Idstring("fonts/font_large_mf"))
    title:set_font_size(24)
    text:set_font_size(20)

	title:set_text(utf8.to_upper(params.title or "ERROR"))
	text:set_text(utf8.to_upper(params.text))
	title:set_visible(true)
	text:set_visible(true)

	local _, _, w, _ = title:text_rect()

	title:set_w(w)

	local _, _, w2, _ = text:text_rect()

	text:set_w(w2)

	local tw = math.max(w, w2)

    self._bg_box:set_w(tw + 16 + 37)
    self._bg_box:set_top(managers.hud._hud_heist_timer._heist_timer_panel:bottom() + 5)
	self._bg_box:set_x(0)

	if params.event then
		managers.hud._sound_source:post_event(params.event)
	end

	present_panel:animate(callback(self, self, "_animate_present_information"), {
		done_cb = callback(self, self, "_present_done"),
		seconds = params.time or 4,
		use_icon = params.icon
	})

	self._presenting = true
end