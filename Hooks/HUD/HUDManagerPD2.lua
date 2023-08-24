dofile(ModPath .. "Hooks/HUD/HUDTeammateWide.lua")

function HUDManager:set_stamina_value(value)
	self._hud_stamina:set_stamina_value(value)
end

function HUDManager:set_max_stamina(value)
	self._hud_stamina:set_max_stamina(value)
end

function HUDManager:_create_teammates_panel(hud)
	if not NepgearsyHUDReborn:IsTeammatePanelWide() then
		hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		self._hud.teammate_panels_data = self._hud.teammate_panels_data or {}
		self._teammate_panels = {}

		if hud.panel:child("teammates_panel") then
			hud.panel:remove(hud.panel:child("teammates_panel"))
		end

		local h = self:teampanels_height()
		local teammates_panel = hud.panel:panel({
			halign = "grow",
			name = "teammates_panel",
			valign = "bottom",
			h = h,
			y = hud.panel:h() - h
		})
		
		local teammate_w = 309
		local player_gap = 0
		local small_gap = ((teammates_panel:w() - player_gap) - teammate_w * 4) / 3

		for i = 1, 4, 1 do
			local is_player = true
			local is_four = i == 4
			self._hud.teammate_panels_data[i] = {
				taken = false and is_player,
				special_equipments = {}
			}
			local pw = teammate_w + (is_player and not is_four and 0 or 10)
			local teammate = HUDTeammate:new(i, teammates_panel, is_player, pw)

			if not _G.IS_VR then
				local x = math.floor((pw + small_gap) * (i - 1) + (i == HUDManager.PLAYER_PANEL and player_gap or 0))

				teammate._panel:set_x(math.floor(x))
			end

			table.insert(self._teammate_panels, teammate)
		end
	else
		local wide_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)

		self._hud.teammate_panels_data = self._hud.teammate_panels_data or {}
		self._teammate_panels = {}

		if wide_hud.panel:child("teammates_panel") then
			wide_hud.panel:remove(wide_hud.panel:child("teammates_panel"))
		end

		local h = 135
		local teammates_panel = wide_hud.panel:panel({
			halign = "grow",
			name = "teammates_panel",
			valign = "bottom",
			h = h,
			y = wide_hud.panel:h() - h
		})
		
		local teammate_w = 336

		local player_gap = 0
		local small_gap = 0

		for i = 1, 4, 1 do
			local is_player = true
			local is_four = i == 4
			self._hud.teammate_panels_data[i] = {
				taken = false and is_player,
				special_equipments = {}
			}
			local pw = teammate_w
			local teammate = HUDTeammateWide:new(i, teammates_panel, is_player, pw)

			if not _G.IS_VR then
				local x = math.floor((pw + small_gap) * (i - 1) + (i == HUDManager.PLAYER_PANEL and player_gap or 0))

				teammate._panel:set_x(math.floor(x))
			end

			table.insert(self._teammate_panels, teammate)
		end
	end
end
--[[
NepHook:Post(HUDManager, "align_teammate_name_label", function(self, panel, interact)
	local nameLabel = panel:child("text")
	local actionLabel = panel:child("action")
	local cheater = panel:child("cheater")

	if nameLabel then
		nameLabel:set_font(Idstring("fonts/font_large_mf"))
		nameLabel:set_font_size(tweak_data.hud.name_label_font_size - 4)
		actionLabel:set_top(nameLabel:bottom())
		actionLabel:set_font(Idstring("fonts/font_large_mf"))
		actionLabel:set_font_size(tweak_data.hud.name_label_font_size - 4)

		cheater:set_visible(false)
	end
end)
]]
NepHook:Post(HUDManager, "add_teammate_panel", function(self, character_name, player_name, ai, peer_id)
	local panel_id = nil

	for i, panel in ipairs(self._teammate_panels) do
		if panel._peer_id == peer_id then
			panel_id = i
			break
		end
	end

	local bg_texture_id = managers.player._player_teammate_bgs[peer_id]
	local bg_texture_path = NepgearsyHUDReborn:GetTeammateSkinById(bg_texture_id)

	if bg_texture_id then
		if self._teammate_panels[panel_id] then
			self._teammate_panels[panel_id]:_update_player_bg(bg_texture_path)
		end
	end
end)

function HUDManager:hide_panels_real_slow(...)
	local function fade_out(o)
		for t, p, dt in seconds(180) do
			o:set_alpha(1 - p)
		end

		o:set_visible(false)
	end

	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	local panels = {
		...
	}

	for _, panel_name in ipairs(panels) do
		local panel = hud.panel:child(panel_name)

		if panel then
			panel:animate(fade_out)
		end
	end
end

--[[ Credits to Luffy for his code below ]]

NepHook:Pre(HUDManager, "_setup_player_info_hud_pd2", function(self)
	if NepgearsyHUDReborn:IsTeammatePanelWide() then
		managers.gui_data:layout_scaled_fullscreen_workspace(managers.hud._saferect, 0.95, 1)
		return
	end

	managers.gui_data:layout_scaled_fullscreen_workspace(managers.hud._saferect, NepgearsyHUDReborn.Options:GetValue("Scale"), NepgearsyHUDReborn.Options:GetValue("Spacing"))
end)

NepHook:Post(HUDManager, "_setup_player_info_hud_pd2", function(self)
	if not self:alive(PlayerBase.PLAYER_INFO_HUD_PD2) then
		return
	end

	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)

	self:_create_stamina_hud(hud)
	self:_create_money_hud(hud)
end)

function HUDManager:recreate_player_info_hud_pd2()
	if not self:alive(PlayerBase.PLAYER_INFO_HUD_PD2) then return end
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self:_create_present_panel(hud)
	self:_create_interaction(hud)
	self:_create_progress_timer(hud)
	self:_create_objectives(hud)
	self:_create_hint(hud)
	self:_create_heist_timer(hud)
	self:_create_temp_hud(hud)
	self:_create_suspicion(hud)
	self:_create_hit_confirm(hud)
	self:_create_hit_direction(hud)
	self:_create_downed_hud()
	self:_create_custody_hud()
	self:_create_waiting_legend(hud)
	self:_create_stamina_hud(hud)
	self:_create_money_hud(hud)
end

function HUDManager:_create_stamina_hud(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_stamina = HUDStamina:new(hud)
end

function HUDManager:_create_money_hud(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_money = HUDMoney:new(hud)
end

core:module("CoreGuiDataManager")
function GuiDataManager:layout_scaled_fullscreen_workspace(ws, scale, on_screen_scale)
	local base_res = {x = 1280, y = 720}
	local res = RenderSettings.resolution
	local sc = (2 - scale)
	local aspect_width = base_res.x / self:_aspect_ratio()
	local h = math.round(sc * math.max(base_res.y, aspect_width))
	local w = math.round(sc * math.max(base_res.x, aspect_width / h))

	local safe_w = math.round(on_screen_scale * res.x)
	local safe_h = math.round(on_screen_scale * res.y)
	local sh = math.min(safe_h, safe_w / (w / h))
	local sw = math.min(safe_w, safe_h * (w / h))
	local x = res.x / 2 - sh * (w / h) / 2
	local y = res.y / 2 - sw / (w / h) / 2
	ws:set_screen(w, h, x, y, math.min(sw, sh * (w / h)))
end