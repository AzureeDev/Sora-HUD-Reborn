function HUDBGBox_create(panel, params, config)
	local box_panel = panel:panel(params)
	local color = config and config.color
	local bg_color = config and config.bg_color or Color(1, 0, 0, 0)
	local blend_mode = config and config.blend_mode

	box_panel:rect({
		blend_mode = "normal",
		name = "bg",
		halign = "grow",
		alpha = 0.25,
		layer = -1,
		valign = "grow",
		color = bg_color
	})

	local left_top = box_panel:bitmap({
		texture = "guis/textures/pd2/hud_corner",
		name = "left_top",
		visible = false,
		layer = 0,
		y = 0,
		halign = "left",
		x = 0,
		valign = "top",
		color = color,
		blend_mode = blend_mode
	})
	local left_bottom = box_panel:bitmap({
		texture = "guis/textures/pd2/hud_corner",
		name = "left_bottom",
		visible = false,
		layer = 0,
		x = 0,
		y = 0,
		halign = "left",
		rotation = -90,
		valign = "bottom",
		color = color,
		blend_mode = blend_mode
	})

	left_bottom:set_bottom(box_panel:h())

	local right_top = box_panel:bitmap({
		texture = "guis/textures/pd2/hud_corner",
		name = "right_top",
		visible = false,
		layer = 0,
		x = 0,
		y = 0,
		halign = "right",
		rotation = 90,
		valign = "top",
		color = color,
		blend_mode = blend_mode
	})

	right_top:set_right(box_panel:w())

	local right_bottom = box_panel:bitmap({
		texture = "guis/textures/pd2/hud_corner",
		name = "right_bottom",
		visible = false,
		layer = 0,
		x = 0,
		y = 0,
		halign = "right",
		rotation = 180,
		valign = "bottom",
		color = color,
		blend_mode = blend_mode
	})

	right_bottom:set_right(box_panel:w())
	right_bottom:set_bottom(box_panel:h())

	return box_panel
end

function HUDObjectives:init(hud)
	self._hud_panel = hud.panel

	if self._hud_panel:child("objectives_panel") then
		self._hud_panel:remove(self._hud_panel:child("objectives_panel"))
	end

	local objectives_panel = self._hud_panel:panel({
		y = 0,
		name = "objectives_panel",
		h = 300,
		visible = true,
		w = 500,
		x = 0,
		valign = "top"
	})
	local icon_objectivebox = objectives_panel:bitmap({
		texture = "guis/textures/pd2/hud_icon_objectivebox",
		name = "icon_objectivebox",
		h = 24,
		layer = 0,
		w = 24,
		y = 0,
		visible = false,
		blend_mode = "normal",
		halign = "left",
		x = 0,
		valign = "top"
	})
	self.icon_objectivebox = icon_objectivebox

	local objective_text = objectives_panel:text({
		y = 0,
		name = "objective_text",
		vertical = "top",
		align = "left",
		text = "",
		visible = true,
		x = 30,
		layer = 2,
		color = Color.white,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow
	})

	self._text_objective_title = objective_text

	local objectives_panel = self._hud_panel:child("objectives_panel")
	objectives_panel:set_left(managers.hud._hud_minimap._panel:right() + 10)
	local text_objective_title = objectives_panel:child("objective_text")
	text_objective_title:set_font(tweak_data.menu.pd2_large_font_id)
	text_objective_title:set_font_size(24)
	text_objective_title:set_color(Color(0.5, 0.5, 1))

	local text_objective_desc = objectives_panel:text({
		font = tweak_data.menu.pd2_large_font,
		font_size = 16,
		wrap = true,
		word_wrap = true,
		color = Color.white,
		layer = 2,
		y = 8,
		w = 300,
		h = 300,
		text = ""
	})
	self._text_objective_desc = text_objective_desc

	text_objective_desc:set_x(text_objective_title:x())
	text_objective_desc:set_y((text_objective_title:y() + text_objective_title:font_size()) + 5)

	local amount_text = objectives_panel:text({
		y = 0,
		name = "amount_text",
		vertical = "top",
		align = "left",
		text = "1/4",
		visible = false,
		x = 6,
		layer = 2,
		color = Color.white,
		font_size = 16,
		font = tweak_data.menu.pd2_large_font
	})

	amount_text:set_x(text_objective_desc:x())
	amount_text:set_y((text_objective_desc:y() + text_objective_desc:font_size()) + 15)
	self._amount_text = amount_text
end

function HUDObjectives:_set_objective_title(title)
	self._text_objective_title:set_text(title)
end

function HUDObjectives:_set_objective_description(desc)
	self._text_objective_desc:set_text(desc)
end

function HUDObjectives:complete_objective(data)
	if data.id == self._active_objective_id then
		local objectives_panel = self._hud_panel:child("objectives_panel")
		objectives_panel:stop()
	end
end

function HUDObjectives:activate_objective(data)
	self._active_objective_id = data.id
	local objectives_panel = self._hud_panel:child("objectives_panel")
	local objective_text = objectives_panel:child("objective_text")

	self.icon_objectivebox:set_visible(true)
	objective_text:set_text(utf8.to_upper(data.text))

	objectives_panel:set_visible(true)
	self._text_objective_title:set_visible(true)
	self._text_objective_desc:set_visible(true)
	self:_set_objective_title(utf8.to_upper(data.text))
	self:_set_objective_description(managers.objectives._objectives[data.id].description)
	self._amount_text:set_visible(false)

	if data.amount then
		self._amount_text:set_x(self._text_objective_desc:x())
		self._amount_text:set_y((self._text_objective_desc:y() + self._text_objective_desc:font_size()) + 20)
		self._amount_text:set_visible(true)
		self:update_amount_objective(data)
	end
end

function HUDObjectives:remind_objective(id)
	if id == self._active_objective_id then
		local objectives_panel = self._hud_panel:child("objectives_panel")

		objectives_panel:stop()
		objectives_panel:animate(callback(self, self, "_animate_activate_objective"))
	end
end

function HUDObjectives:_animate_complete_objective(objectives_panel)
end