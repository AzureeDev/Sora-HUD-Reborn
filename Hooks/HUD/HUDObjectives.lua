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
		name = "objectives_panel",
		h = 28,
		w = 500,
		y = 13
	})

	local icon_objectivebox = objectives_panel:bitmap({
		texture = "NepgearsyHUDReborn/HUD/ObjectiveSquare",
		name = "icon_objectivebox",
		h = 24,
		layer = 0,
		w = 24,
		y = 2,
		visible = false,
		blend_mode = "normal",
		halign = "left",
		x = 2,
		valign = "center",
		color = NepgearsyHUDReborn:StringToColor("objective_color", NepgearsyHUDReborn:GetOption("ObjectiveColor"))
	})
	self.icon_objectivebox = icon_objectivebox

	local objective_text = objectives_panel:text({
		y = 3,
		name = "objective_text",
		vertical = "center",
		align = "left",
		text = "",
		visible = true,
		layer = 2,
		color = Color.white,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = "fonts/font_large_mf"
	})
	managers.hud:make_fine_text(objective_text)
	self._text_objective_title = objective_text
	self._text_objective_title:set_left(self.icon_objectivebox:right() + 5)

	local objectives_panel = self._hud_panel:child("objectives_panel")
	managers.hud._hud_minimap._panel:set_top(self.icon_objectivebox:bottom() + 20)

	local amount_text = objectives_panel:text({
		y = 2,
		name = "amount_text",
		align = "left",
		vertical = "center",
		text = "",
		visible = false,
		layer = 2,
		color = Color(0.6, 0.6, 0.6),
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = "fonts/font_large_mf"
	})
	amount_text:set_left(objective_text:right() + 10)
	self._amount_text = amount_text
end

function HUDObjectives:_set_objective_title(title)
	self._text_objective_title:set_text(title)
	managers.hud:make_fine_text(self._text_objective_title)
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
	self:_set_objective_title(utf8.to_upper(data.text))
	self._amount_text:set_visible(false)

	if data.amount then
		self._amount_text:set_visible(true)
		self:update_amount_objective(data)
	end
end

function HUDObjectives:update_amount_objective(data)
	if data.id == self._active_objective_id then
		local current = data.current_amount or 0
		local amount = data.amount
		local objectives_panel = self._hud_panel:child("objectives_panel")
		local amount_text = objectives_panel:child("amount_text")

		if alive(amount_text) then
			amount_text:set_text("( " .. current .. "/" .. amount .. " )")
			amount_text:set_left(self._text_objective_title:right() + 10)
		end
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