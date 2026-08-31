if NepgearsyHUDReborn:GetOption("EnableInteraction") then
    function HUDInteraction:init(hud, child_name)
        self._hud_panel = hud.panel
        self._circle_radius = 64
        self._sides = 64
        self._child_name_text = (child_name or "interact") .. "_text"
        self._child_ivalid_name_text = (child_name or "interact") .. "_invalid_text"

        if self._hud_panel:child(self._child_name_text) then
            self._hud_panel:remove(self._hud_panel:child(self._child_name_text))
        end

        if self._hud_panel:child(self._child_ivalid_name_text) then
            self._hud_panel:remove(self._hud_panel:child(self._child_ivalid_name_text))
        end

        local font_type = "fonts/font_large_mf"
        if NepgearsyHUDReborn:GetOption("InteractionFont") == 2 then
            font_type = "fonts/font_eurostile_ext"
        elseif NepgearsyHUDReborn:GetOption("InteractionFont") == 3 then
            font_type = "fonts/font_pdth"
        end

        local interact_text = self._hud_panel:text({
            name = self._child_name_text,
            text = "",
            layer = 1,
            align = "center",
            valign = "center",
            h = 64,
            visible = false,
            alpha = 0,
            font = font_type,
            font_size = tweak_data.hud_present.text_size - 8
        })
        local invalid_text = self._hud_panel:text({
            name = self._child_ivalid_name_text,
            text = "",
            layer = 3,
            y = interact_text:y(),
            align = "center",
            valign = "center",
            blend_mode = "normal",
            h = 64,
            visible = false,
            color = Color(1, 0.3, 0.3),
            font = font_type,
            font_size = tweak_data.hud_present.text_size - 8
        })
        interact_text:set_y(self._hud_panel:h() / 2 + 144)
        invalid_text:set_center_y(interact_text:center_y())

        self._interact_bar_contour = self._hud_panel:bitmap({
            name = "interact_bar_contour",
            texture = "NepgearsyHUDReborn/HUD/InteractionBarContour",
            w = 333,
            h = 45,
            layer = 2,
            alpha = 0
        })

        self._interact_bar_progress = self._hud_panel:bitmap({
            name = "interact_bar_progress",
            texture = "NepgearsyHUDReborn/HUD/InteractionBarProgress",
            w = 0,
            h = 45,
            color = NepgearsyHUDReborn:GetOption("SoraInteractionColor"),
            layer = 1,
            alpha = 0
        })

        self._interact_bar_background = self._hud_panel:bitmap({
            name = "interact_bar_bg",
            texture = "NepgearsyHUDReborn/HUD/InteractionBarEmpty",
            w = 333,
            h = 45,
            layer = 0,
            alpha = 0
        })
    end

    NepHook:Post(HUDInteraction, "show_interact", function(self)
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_in"))
    end)

    function HUDInteraction:remove_interact()
        if not alive(self._hud_panel) then
            return
        end

        self._hud_panel:child(self._child_ivalid_name_text):set_visible(false)
        self._hud_panel:child(self._child_name_text):stop()
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_out"))
    end

    NepHook:Post(HUDInteraction, "show_interaction_bar", function(self, current, total)
        if self._interact_circle and self._interact_circle:visible() then
            self._interact_circle:set_visible(false)
        end

        self:reset_interaction_bar()

        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_in"))
        self._interact_bar_contour:animate(callback(self, self, "_animate_fade_in"))
        self._interact_bar_progress:animate(callback(self, self, "_animate_fade_in"))
        self._interact_bar_background:animate(callback(self, self, "_animate_fade_in"))

        self._interact_bar_contour:set_position(self._hud_panel:w() / 2 - (333 / 2), self._hud_panel:h() / 2 + 120)
        self._interact_bar_progress:set_position(self._hud_panel:w() / 2 - (333 / 2), self._hud_panel:h() / 2 + 120)
        self._interact_bar_background:set_position(self._hud_panel:w() / 2 - (333 / 2), self._hud_panel:h() / 2 + 120)
    end)

    NepHook:Post(HUDInteraction, "set_interaction_bar_width", function(self, current, total)
        if self._interact_bar_progress then
            local calc = math.clamp(current / total, 0, 500) * 333

            if (calc == 0) then
                self._interact_bar_progress:set_alpha(0)
            end

            if calc > 333 then
                calc = 333
            end

            self._interact_bar_progress:set_w(calc)
        end
    end)

    function HUDInteraction:hide_interaction_bar()
        self._interact_bar_contour:animate(callback(self, self, "_animate_fade_out"))
        self._interact_bar_progress:animate(callback(self, self, "_animate_fade_out"))
        self._interact_bar_background:animate(callback(self, self, "_animate_fade_out"))
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_out"))

        self:reset_interaction_bar()
    end

    function HUDInteraction:reset_interaction_bar()
        self._hud_panel:remove(self._hud_panel:child("interact_bar_contour"))
        self._hud_panel:remove(self._hud_panel:child("interact_bar_progress"))
        self._hud_panel:remove(self._hud_panel:child("interact_bar_bg"))

        self._interact_bar_contour = self._hud_panel:bitmap({
            name = "interact_bar_contour",
            texture = "NepgearsyHUDReborn/HUD/InteractionBarContour",
            w = 333,
            h = 45,
            layer = 2,
            alpha = 0
        })

        self._interact_bar_progress = self._hud_panel:bitmap({
            name = "interact_bar_progress",
            texture = "NepgearsyHUDReborn/HUD/InteractionBarProgress",
            w = 0,
            h = 45,
            color = NepgearsyHUDReborn:GetOption("SoraInteractionColor"),
            layer = 1,
            alpha = 0
        })

        self._interact_bar_background = self._hud_panel:bitmap({
            name = "interact_bar_bg",
            texture = "NepgearsyHUDReborn/HUD/InteractionBarEmpty",
            w = 333,
            h = 45,
            layer = 0,
            alpha = 0
        })
    end

    function HUDInteraction:set_bar_valid(valid, text_id)
        self._interact_bar_progress:set_color(valid and NepgearsyHUDReborn:GetOption("SoraInteractionColor") or Color(1, 0.3, 0.3))
        self._hud_panel:child(self._child_name_text):set_visible(valid)

        local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)

        if text_id then
            invalid_text:set_text(managers.localization:to_upper_text(text_id))
        end

        invalid_text:set_visible(not valid)
    end

    function HUDInteraction:destroy()
        self._hud_panel:remove(self._hud_panel:child(self._child_name_text))
        self._hud_panel:remove(self._hud_panel:child(self._child_ivalid_name_text))

        if self._interact_bar_contour and self._interact_bar_background and self._interact_bar_progress then
            self._hud_panel:remove(self._hud_panel:child("interact_bar_contour"))
            self._hud_panel:remove(self._hud_panel:child("interact_bar_progress"))
            self._hud_panel:remove(self._hud_panel:child("interact_bar_bg"))
            self._interact_bar_contour = nil
            self._interact_bar_progress = nil
            self._interact_bar_background = nil
        end
    end

    function HUDInteraction:_animate_fade_out(o)
        play_value(o, "alpha", 0)
    end

    function HUDInteraction:_animate_fade_in(o)
        play_value(o, "alpha", 1)
    end
end