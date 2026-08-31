NepHook:Post(HUDHint, "init", function(self)
	self._hint_panel:set_visible(true)
	self._hint_panel:child("marker"):set_visible(false)
	local clip_panel = self._hint_panel:child("clip_panel")
	clip_panel:child("bg"):set_visible(false)

	clip_panel:text({
		name = "hint_text",
		vertical = "center",
		word_wrap = false,
		wrap = false,
		font_size = 24,
		align = "center",
		text = "",
		layer = 1,
		font = "fonts/font_large_mf",
		color = Color.white,
		alpha = 0
	})

	self._hint_panel:set_center_y(105)
end)

function HUDHint:_animate_show(o, done_cb, seconds, text)
	self._hint_panel:child("clip_panel"):child("hint_text"):set_text(text)

	play_value(o, "alpha", 1)
	wait(seconds)
	play_value(o, "alpha", 0)
	done_cb()
end