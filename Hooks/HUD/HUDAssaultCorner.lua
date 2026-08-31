if RequiredScript == "lib/managers/hud/hudassaultcorner" then
    local init_orig = HUDAssaultCorner.init
    function HUDAssaultCorner:init(hud, full_hud, tweak_hud)
        init_orig(self, hud, full_hud, tweak_hud)

        hud.panel:child("assault_panel"):set_visible(false)
        hud.panel:child("casing_panel"):set_visible(false)
        hud.panel:child("hostages_panel"):set_visible(false)
        self._bg_box:set_visible(false)

        self._scale = NepgearsyHUDReborn:GetOption("AssaultScale")
        self._trackers_scale = NepgearsyHUDReborn:GetOption("AssaultTrackersScale")
        self.totalKilledSession = 0
        self.civKills = 0

        local assault_panel_v2 = self._hud_panel:panel({
            name = "assault_panel_v2",
            w = 320 * self._scale,
            h = 36 * self._scale,
            visible = not self:is_safehouse()
        })
        self._assault_panel_v2 = assault_panel_v2
        assault_panel_v2:set_top(0)
        assault_panel_v2:set_right(self._hud_panel:w())

        local assault_bar_under = assault_panel_v2:panel({
            name = "assault_bar_under",
            w = 320 * self._scale,
            h = 18 * self._scale,
            visible = false
        })
        local assault_bar_under_bmp = assault_bar_under:bitmap({
            name = "assault_bar_under_bmp",
            texture = "NepgearsyHUDReborn/HUD/AssaultBarUnder",
            x = 1 * self._scale,
            w = 320 * self._scale,
            h = 18 * self._scale,
            color = Color.white,
            visible = true
        })

        self._assault_banner = assault_panel_v2:panel({
            w = 320 * self._scale,
            h = 36 * self._scale,
            visible = true
        })

        assault_panel_v2:panel({
            name = "text_panel",
            layer = 1,
            w = self._assault_banner:w() - 20 * self._scale
        }):set_center(self._assault_banner:center())

        local assaultBanner = self._assault_banner:bitmap({
            name = "assaultBanner",
            texture = "NepgearsyHUDReborn/HUD/AssaultBar",
            w = 320 * self._scale,
            h = 36 * self._scale,
            color = NepgearsyHUDReborn:GetOption("SoraStealthBarColor"),
            visible = true
        })

        local textAssaultBanner = self._assault_banner:text({
            name = "textAssaultBanner",
            text = "",
            font = "fonts/font_large_mf",
            font_size = 25 * self._scale,
            vertical = "center",
            align = "right",
            x = -10,
            color = Color.black,
            layer = 2
        })

        local PointOfNoReturnPanel = self._hud_panel:panel({
            w = 108 * self._scale,
            h = 36 * self._scale
        })
        PointOfNoReturnPanel:set_top(0)
        PointOfNoReturnPanel:set_right(assault_panel_v2:left())

        local NoReturnChronoPanel = self._hud_panel:panel({
            h = 40,
            layer = 0,
            valign = "top"
        })

        self.NoReturnText = NoReturnChronoPanel:text({
            font = NepgearsyHUDReborn:SetFont("fonts/font_eurostile_ext"),
            font_size = 25 * self._scale,
            vertical = "top",
            align = "center",
            text = "0:00",
            color = NepgearsyHUDReborn:GetOption("SoraPONRBarColor"),
            alpha = 0
        })

        local trackerPanel = self._hud_panel:panel({
            name = "trackerPanel",
            w = 356 * self._trackers_scale,
            h = 40 * self._trackers_scale,
            visible = NepgearsyHUDReborn:GetOption("EnableTrackers") and not self:is_safehouse()
        })
        trackerPanel:set_right(self._hud_panel:w())
        trackerPanel:set_top(assault_panel_v2:bottom() + 5 * self._trackers_scale)

        local killTracker = trackerPanel:panel({
            w = 60 * self._trackers_scale,
            h = 24 * self._trackers_scale,
            x = 295 * self._trackers_scale
        })

        local killTrackerRect = killTracker:rect({
            name = "background",
            color = Color.white,
            alpha = 0.6,
            layer = -1,
            halign = "scale",
            valign = "scale"
        })

        local killTrackerSkull = killTracker:bitmap({
            w = 15 * self._trackers_scale,
            h = 20 * self._trackers_scale,
            texture = "NepgearsyHUDReborn/HUD/Skull",
            color = Color.black,
            align = "left",
            x = 2,
            y = 2
        })
        killTrackerSkull:set_center_y(killTracker:center_y())

        self.killTrackerAmount = killTracker:text({
            font = "fonts/font_large_mf",
            font_size = 20 * self._trackers_scale,
            vertical = "center",
            align = "right",
            text = tostring(self.totalKilledSession),
            color = Color.black
        })
        self.killTrackerAmount:set_right(killTracker:w() - 9 * self._trackers_scale)
        self.killTrackerAmount:set_center_y(killTracker:h() / 2 + 1.1 * self._trackers_scale)

        local copTracker = trackerPanel:panel({
            w = 60 * self._trackers_scale,
            h = 24 * self._trackers_scale,
            visible = NepgearsyHUDReborn:GetOption("EnableCopTracker")
        })
        copTracker:set_right(killTracker:left() - 5)
        copTracker:set_top(killTracker:top())

        local copTrackerRect = copTracker:rect({
            name = "background",
            color = Color.white,
            alpha = 0.6,
            layer = -1,
            halign = "scale",
            valign = "scale"
        })

        local copTrackerIcon = copTracker:bitmap({
            w = 15 * self._trackers_scale,
            h = 20 * self._trackers_scale,
            texture = "NepgearsyHUDReborn/HUD/Cop",
            color = Color.black,
            align = "left",
            x = 2,
            y = 2
        })
        copTrackerIcon:set_center_y(copTracker:center_y())

        self.copTrackerAmount = copTracker:text({
            font = "fonts/font_large_mf",
            font_size = 20 * self._trackers_scale,
            vertical = "center",
            align = "right",
            text = tostring(managers.enemy._enemy_data.nr_units),
            color = Color.black
        })
        self.copTrackerAmount:set_right(copTracker:w() - 9 * self._trackers_scale)
        self.copTrackerAmount:set_center_y(copTracker:h() / 2 + 1.1 * self._trackers_scale)

        local hostage_panel = self._hud_panel:panel({
            name = "hostage_panel",
            w = 60,
            h = 24,
            visible = not self:is_safehouse() and not self:is_zm()
        })
        hostage_panel:set_left(managers.hud._hud_heist_timer._heist_timer_panel:right() + 5)
        hostage_panel:set_top(managers.hud._hud_heist_timer._heist_timer_panel:top())

        local hostage_icon = hostage_panel:bitmap({
            texture = "guis/textures/pd2/hud_icon_hostage",
            name = "hostage_icon",
            layer = 1,
            w = 20,
            h = 20,
            x = 2,
            y = 2,
            color = Color.black
        })

        local hostage_rect = hostage_panel:rect({
            name = "hostage_rect",
            color = Color.white,
            alpha = 0.6,
            layer = -1,
            halign = "scale",
            valign = "scale"
        })

        self.num_hostages = hostage_panel:text({
            layer = 1,
            vertical = "center",
            name = "num_hostages",
            align = "right",
            text = "0",
            y = 1,
            x = -10,
            color = Color.black,
            font = "fonts/font_large_mf",
            font_size = 20
        })

        local hostageKilledPanel = self._hud_panel:panel({
            name = "hostageKilledPanel",
            w = 60,
            h = 24,
            visible = NepgearsyHUDReborn:GetOption("EnableTrackers")
        })
        hostageKilledPanel:set_left(hostage_panel:right() + 5)
        hostageKilledPanel:set_top(hostage_panel:top())

        self.hostageKilledBg = hostageKilledPanel:rect({
            name = "hostageKilledBg",
            color = Color.white,
            alpha = 0.6,
            layer = -1,
            halign = "scale",
            valign = "scale"
        })

        local hostageKilledIcon = hostageKilledPanel:bitmap({
            texture = "NepgearsyHUDReborn/HUD/CivilianKilled",
            name = "hostageKilledIcon",
            layer = 1,
            w = 20,
            h = 20,
            x = 2,
            y = 2,
            color = Color.black
        })

        self.hostageKilledCounter = hostageKilledPanel:text({
            layer = 1,
            vertical = "center",
            name = "hostageKilledCounter",
            align = "right",
            text = "0:05",
            y = 1,
            x = -5,
            color = Color.black,
            font = "fonts/font_large_mf",
            font_size = 20
        })

        self._hud_panel:child("buffs_panel"):set_size(40, 40)
        self._hud_panel:child("buffs_panel"):set_top(assault_panel_v2:top())
        self._hud_panel:child("buffs_panel"):set_right(assault_panel_v2:left() - 5)

        self._vip_bg_box:set_w(40)
        self._vip_bg_box:set_h(40)
        self._vip_bg_box:set_x(0)
        self._vip_bg_box:child("vip_icon"):set_center(self._vip_bg_box:w() / 2, self._vip_bg_box:h() / 2)

        if managers.skirmish:is_skirmish() or self:is_safehouse_raid() then
            local wave_panel = self._hud_panel:child("wave_panel"):set_visible(false)
            self._wave_bg_box:set_visible(false)
        end

        local waveTracker = trackerPanel:panel({
            w = 90 * self._trackers_scale,
            h = 24 * self._trackers_scale,
            visible = managers.skirmish:is_skirmish() or self:is_safehouse_raid()
        })

        if NepgearsyHUDReborn:GetOption("EnableCopTracker") then
            waveTracker:set_right(copTracker:left() - 5)
        else
            waveTracker:set_right(killTracker:left() - 5)
        end
        waveTracker:set_top(killTracker:top())

        local waveBG = waveTracker:rect({
            name = "background",
            color = Color.white,
            alpha = 0.6,
            layer = -1,
            halign = "scale",
            valign = "scale"
        })

        local waveIcon = waveTracker:bitmap({
            texture = "guis/textures/pd2/specialization/icons_atlas",
            name = "wave_icon",
            layer = 1,
            align = "left",
            valign = "top",
            y = 2,
            x = 2,
            texture_rect = {
                192,
                64,
                64,
                64
            },
            w = 20 * self._trackers_scale,
            h = 20 * self._trackers_scale,
            color = Color.black
        })
        waveIcon:set_center_y(waveTracker:center_y())

        self.waveTrackerAmount = waveTracker:text({
            font = "fonts/font_large_mf",
            font_size = 20 * self._trackers_scale,
            vertical = "center",
            align = "right",
            text = self:get_completed_waves_string(),
            color = Color.black
        })
        self.waveTrackerAmount:set_right(waveTracker:w() - 9 * self._trackers_scale)
        self.waveTrackerAmount:set_center_y(waveTracker:h() / 2 + 1.1 * self._trackers_scale)

        if managers.groupai:state():whisper_mode() then
            self._current_assault_color = NepgearsyHUDReborn:GetOption("SoraStealthBarColor")
            self:_set_text_list(self:_get_stealth_textlist())
            local box_text_panel = self._assault_panel_v2:child("text_panel")
            box_text_panel:stop()
            box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"), 35)
            box_text_panel:animate(callback(self, self, "_show_blink"))
        end

        self._vip_assault_color = NepgearsyHUDReborn:GetOption("SoraWintersBarColor")
        self._assault_color = NepgearsyHUDReborn:GetOption("SoraAssaultBarColor")
    end

    NepHook:Post(HUDAssaultCorner, "set_assault_wave_number", function(self, assault_number)
        if alive(self.waveTrackerAmount) then
            self.waveTrackerAmount:set_text(self:get_completed_waves_string())
        end
    end)

    function HUDAssaultCorner:is_safehouse_raid()
        return managers.job:current_level_id() == "chill_combat"
    end

    function HUDAssaultCorner:is_safehouse()
        return managers.job:current_level_id() == "chill"
    end

    function HUDAssaultCorner:is_zm()
        return managers.job:current_level_id() == "zm_broken_arrow" or managers.job:current_level_id() == "zm_the_forest"
    end

    function HUDAssaultCorner:_update_assault_hud_color(color)
        self._current_assault_color = color

        local assaultBanner = self._assault_banner:child("assaultBanner")
        assaultBanner:set_color(color)
    end

    function HUDAssaultCorner:show_casing() return end

    function HUDAssaultCorner:_start_assault(text_list, s)
        text_list = text_list or {
            ""
        }
        local assault_panel = self._hud_panel:child("assault_panel_v2")
        local text_panel = assault_panel:child("text_panel")

        self:_set_text_list(text_list)

        self._assault = true

        if text_panel then
            text_panel:stop()
            text_panel:clear()
            text_panel:set_w(assault_panel:w() - 26 * self._scale)
        else
            assault_panel:panel({ name = "text_panel", w = assault_panel:w() - 30 * self._scale })
        end

        local config = {
            attention_forever = true,
            attention_color = self._assault_color,
            attention_color_function = callback(self, self, "assault_attention_color_function")
        }

        text_panel:stop()
        text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"), s)
        text_panel:animate(callback(self, self, "_show_blink"))
        self:_set_feedback_color(self._assault_color)

        if alive(self._wave_bg_box) then
            self._wave_bg_box:stop()
            self._wave_bg_box:animate(callback(self, self, "_animate_wave_started"), self)
        end

        if self:is_zm() then
            self:_update_assault_hud_color(Color.red)
        end
    end

    function HUDAssaultCorner:_start_slow_assault(text_list)
        self:_start_assault(text_list, 35)
    end

    function HUDAssaultCorner:_end_assault()
        if not self._assault then
            self._start_assault_after_hostage_offset = nil

            return
        end

        self:_set_feedback_color(nil)

        self._assault = false
        local box_text_panel = self._assault_panel_v2:child("text_panel")

        box_text_panel:animate(callback(self, self, "_show_blink"))

        self._remove_hostage_offset = true
        self._start_assault_after_hostage_offset = nil

        self:_update_assault_hud_color(NepgearsyHUDReborn:GetOption("SoraSurvivedBarColor"))
        self:_start_assault(self:_get_incoming_textlist())
        --self:_update_assault_hud_color(self._assault_survived_color)
        --self:_set_text_list(self:_get_survived_assault_strings())
        --box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"), 35)

        if managers.skirmish:is_skirmish() or self:is_safehouse_raid() then
            self._wave_bg_box:stop()
            self._wave_bg_box:animate(callback(self, self, "_animate_wave_completed"), self)
        end
    end

    function HUDAssaultCorner:_set_text_list(text_list)
        local assault_panel = self._hud_panel:child("assault_panel_v2")
        local text_panel = assault_panel:child("text_panel")
        text_panel:script().text_list = text_panel:script().text_list or {}

        while #text_panel:script().text_list > 0 do
            table.remove(text_panel:script().text_list)
        end

        self._assault_banner:script().text_list = self._assault_banner:script().text_list or {}

        while #self._assault_banner:script().text_list > 0 do
            table.remove(self._assault_banner:script().text_list)
        end

        for _, text_id in ipairs(text_list) do
            table.insert(text_panel:script().text_list, text_id)
            table.insert(self._assault_banner:script().text_list, text_id)
        end
    end

    function HUDAssaultCorner:_animate_text(text_panel, bg_box, color, color_function)
        local text_list = (bg_box or self._assault_banner):script().text_list
        local text_index = 0
        local texts = {}
        local padding = 10 * self._scale

        local function create_new_text(text_panel, text_list, text_index, texts)
            if texts[text_index] and texts[text_index].text then
                text_panel:remove(texts[text_index].text)

                texts[text_index] = nil
            end

            local text_id = text_list[text_index]
            local text_string = ""

            if type(text_id) == "string" then
                text_string = managers.localization:to_upper_text(text_id)
            elseif text_id == Idstring("risk") then
                local use_stars = true

                if managers.crime_spree:is_active() then
                    text_string = text_string .. managers.localization:to_upper_text("menu_cs_level", {
                        level = managers.experience:cash_string(managers.crime_spree:server_spree_level(), "")
                    })
                    use_stars = false
                end

                if use_stars then
                    for i = 1, managers.job:current_difficulty_stars() do
                        text_string = text_string .. managers.localization:get_default_macro("BTN_SKULL")
                    end
                end
            end

            local font_type = "fonts/font_large_mf"
            if NepgearsyHUDReborn:GetOption("AssaultBarFont") == 2 then
                font_type = "fonts/font_eurostile_ext"
            elseif NepgearsyHUDReborn:GetOption("AssaultBarFont") == 3 then
                font_type = "fonts/font_pdth"
            end

            local mod_color = color_function and color_function() or color or self._assault_color
            local text = text_panel:text({
                vertical = "center",
                h = 10 * self._scale,
                w = 10 * self._scale,
                align = "center",
                blend_mode = "add",
                layer = 1,
                text = text_string,
                color = mod_color,
                font_size = tweak_data.hud_corner.assault_size * self._scale,
                font = NepgearsyHUDReborn:SetFont(font_type)
            })
            local _, _, w, h = text:text_rect()

            text:set_size(w, h)

            texts[text_index] = {
                x = text_panel:w() + w * 0.5 + padding * 2,
                text = text
            }
        end

        while true do
            local dt = coroutine.yield()
            local last_text = texts[text_index]

            if last_text and last_text.text then
                if last_text.x + last_text.text:w() * 0.5 + padding < text_panel:w() then
                    text_index = text_index % #text_list + 1

                    create_new_text(text_panel, text_list, text_index, texts)
                end
            else
                text_index = text_index % #text_list + 1

                create_new_text(text_panel, text_list, text_index, texts)
            end

            local speed = 90 * self._scale

            for i, data in pairs(texts) do
                if data.text then
                    data.x = data.x - dt * speed

                    data.text:set_center_x(data.x)
                    data.text:set_center_y(text_panel:h() * 0.5)

                    if data.x + data.text:w() * 0.5 < 0 then
                        text_panel:remove(data.text)

                        data.text = nil
                    elseif color_function then
                        data.text:set_color(color_function())
                    end
                end
            end
        end
    end

    function HUDAssaultCorner:show_point_of_no_return_timer()
        local delay_time = self._assault and 1.2 or 0

        self:_start_assault(self:_get_no_return_textlist())

        local box_text_panel = self._assault_panel_v2:child("text_panel")

        box_text_panel:stop()
        box_text_panel:clear()
        box_text_panel:animate(callback(self, self, "_animate_show_noreturn"), delay_time)
        self.NoReturnText:animate(callback(self, self, "_show_blink"))
        self:_set_feedback_color(NepgearsyHUDReborn:GetOption("SoraPONRBarColor"))
        self:_update_assault_hud_color(NepgearsyHUDReborn:GetOption("SoraPONRBarColor"))

        self._point_of_no_return = true
    end

    function HUDAssaultCorner:_animate_show_noreturn(point_of_no_return_panel, delay_time)
        wait(delay_time)
    end

    function HUDAssaultCorner:flash_point_of_no_return_timer(beep)
        local function flash_timer(o)
            local t = 0

            while t < 0.5 do
                t = t + coroutine.yield()
                local n = 1 - math.sin(t * 180)
                local r = math.lerp(1 or self._point_of_no_return_color.r, 1, n)
                local g = math.lerp(0 or self._point_of_no_return_color.g, 0.8, n)
                local b = math.lerp(0 or self._point_of_no_return_color.b, 0.2, n)

                o:set_color(Color(r, g, b))
                o:set_font_size(math.lerp(tweak_data.hud_corner.noreturn_size, tweak_data.hud_corner.noreturn_size * 1.25, n))
            end
        end

        self.NoReturnText:animate(flash_timer)
    end

    function HUDAssaultCorner:set_control_info(data)
        self.num_hostages:set_text(data.nr_hostages)
        self.num_hostages:animate(callback(self, self, "_show_blink"))
    end

    function HUDAssaultCorner:_show_icon_assaultbox() end

    function HUDAssaultCorner:_hide_icon_assaultbox() end

    function HUDAssaultCorner:hide_point_of_no_return_timer()
        self.NoReturnText:animate(callback(self, self, "_hide_blink"))

        self._point_of_no_return = false

        self:_update_assault_hud_color(NepgearsyHUDReborn:GetOption("SoraAssaultBarColor"))
        self:_start_assault(self:_get_assault_strings())
        self:_set_feedback_color(nil)
    end

    function HUDAssaultCorner:_hide_blink(target)
        local TOTAL_T = 2
        local t = TOTAL_T

        while t > 0 do
            local dt = coroutine.yield()
            t = t - dt
            local alpha = math.round(math.abs(math.cos(t * 360 * 2)))

            target:set_alpha(alpha)
        end

        target:set_alpha(0)
        target:stop()
        target:clear()
        target:set_alpha(1)
    end

    function HUDAssaultCorner:_show_blink(target)
        local TOTAL_T = 3
        local t = TOTAL_T

        while t > 0 do
            local dt = coroutine.yield()
            t = t - dt
            local alpha = math.round(math.abs(math.cos(t * 360 * 2)))

            target:set_alpha(alpha)
        end

        target:set_alpha(1)
    end

    function HUDAssaultCorner:_get_stealth_textlist()
        if managers.job:current_difficulty_stars() > 0 then
            local ids_risk = Idstring("risk")

            return {
                "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
                "hud_assault_end_line",
                ids_risk,
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
                "hud_assault_end_line",
                ids_risk,
                "hud_assault_end_line"
            }
        else
            return {
                "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/Chill",
                "hud_assault_end_line"
            }
        end
    end

    function HUDAssaultCorner:_get_incoming_textlist()
        if managers.job:current_difficulty_stars() > 0 then
            local ids_risk = Idstring("risk")

            return {
                "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
                "hud_assault_end_line",
                ids_risk,
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
                "hud_assault_end_line",
                ids_risk,
                "hud_assault_end_line"
            }
        else
            return {
                "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/Coming",
                "hud_assault_end_line"
            }
        end
    end

    function HUDAssaultCorner:_get_no_return_textlist()
        if managers.job:current_difficulty_stars() > 0 then
            local ids_risk = Idstring("risk")

            return {
                "NepgearsyHUDReborn/HUD/AssaultCorner/NoReturn",
                "hud_assault_end_line",
                ids_risk,
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/NoReturn",
                "hud_assault_end_line",
                ids_risk,
                "hud_assault_end_line"
            }
        else
            return {
                "NepgearsyHUDReborn/HUD/AssaultCorner/NoReturn",
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/NoReturn",
                "hud_assault_end_line",
                "NepgearsyHUDReborn/HUD/AssaultCorner/NoReturn",
                "hud_assault_end_line"
            }
        end
    end

    function HUDAssaultCorner:feed_point_of_no_return_timer(time, is_inside)
        time = math.floor(time)
        local minutes = math.floor(time / 60)
        local seconds = math.round(time - minutes * 60)
        local text = (minutes < 10 and "0" .. minutes or minutes) .. ":" .. (seconds < 10 and "0" .. seconds or seconds)

        self.NoReturnText:set_text(text)
        self.NoReturnText:set_visible(true)
    end

elseif RequiredScript == "lib/managers/mission/elementterminateassault" then
    function ElementTerminateAssault:on_executed(instigator)
        local state = managers.groupai:state()
        if state.terminate_assaults then
            state:terminate_assaults()
            managers.hud:hide_panels("assault_panel")
        end

        managers.hud._hud_assault_corner:_update_assault_hud_color(Color.white)
        managers.hud._hud_assault_corner:_start_slow_assault({
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

        managers.hud:hide_panels_real_slow("assault_panel_v2", "trackerPanel", "hostage_panel")
        ElementTerminateAssault.super.on_executed(self, instigator)
    end

elseif RequiredScript == "lib/managers/group_ai_states/groupaistatebesiege" then
    NepHook:Post(GroupAIStateBesiege, "_upd_recon_tasks", function(self)
        local assault_corner = managers.hud._hud_assault_corner
        --local box_text_panel = assault_corner._assault_panel_v2:child("text_panel")
        if not assault_corner._assault and not assault_corner._point_of_no_return then
            assault_corner:_update_assault_hud_color(NepgearsyHUDReborn:GetOption("SoraSurvivedBarColor"))
            assault_corner:_start_assault(assault_corner:_get_incoming_textlist())
        end
    end)

elseif RequiredScript == "lib/managers/hud/hudplayercustody" then
    NepHook:Post(HUDPlayerCustody, "set_trade_delay", function(self, time)
        if time < 5 then
            managers.hud._hud_assault_corner.hostageKilledBg:set_color(Color.white)
            return
        end

        managers.hud._hud_assault_corner.hostageKilledCounter:set_text(self:_get_time_text(time))
    end)

elseif RequiredScript == "lib/units/civilians/civiliandamage" then
    NepHook:Post(CivilianDamage, "_on_damage_received", function(self, damage_info)
        if damage_info.result.type == "death" and damage_info.attacker_unit == managers.player:player_unit() then
            managers.hud._hud_assault_corner.civKills = (managers.hud._hud_assault_corner.civKills or 0) + 1
    
            local assault_corner = managers.hud._hud_assault_corner

            local base_timer = 5
            local civ_kill_penalty = 30 * assault_corner.civKills
            local addition = base_timer + civ_kill_penalty
            local time_text = managers.hud._hud_player_custody:_get_time_text(addition)

            assault_corner.hostageKilledCounter:set_text(time_text)
            assault_corner.hostageKilledBg:set_color(Color.red)
            assault_corner.hostageKilledCounter:animate(callback(assault_corner, assault_corner, "_show_blink"))
        end
    end)

elseif RequiredScript == "lib/managers/statisticsmanager" then
    NepHook:Post(StatisticsManager, "killed", function()
        managers.hud._hud_assault_corner.totalKilledSession = (managers.hud._hud_assault_corner.totalKilledSession or 0) + 1

        local total_killed = managers.hud._hud_assault_corner.totalKilledSession
        managers.hud._hud_assault_corner.killTrackerAmount:set_text(tostring(total_killed))

        if NepgearsyHUDReborn:GetOption("UseDiscordRichPresence") and NepgearsyHUDReborn:GetOption("DiscordRichPresenceType") == 2 then
            NepgearsyHUDReborn:SetDiscordPresence("/// Killing in Progress ///", total_killed .. " kills")
        end
    end)

elseif RequiredScript == "lib/managers/enemymanager" then
    local update = function(self)
        if managers.hud and managers.hud._hud_assault_corner then
            managers.hud._hud_assault_corner.copTrackerAmount:set_text(self._enemy_data.nr_units)
        end
    end

    NepHook:Post(EnemyManager, "on_enemy_registered", update)
    NepHook:Post(EnemyManager, "on_enemy_unregistered", update)
end
