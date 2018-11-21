if NepgearsyHUDReborn:HasInteractionEnabled() then
    NepHook:Post(HUDInteraction, "init", function(self)
        local interact_text = self._hud_panel:child(self._child_name_text)
        local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)

        if NepgearsyHUDReborn.Options:GetValue("InteractionFont") == 1 then
            interact_text:set_font(Idstring("fonts/font_eurostile_ext"))
            invalid_text:set_font(Idstring("fonts/font_eurostile_ext"))
            interact_text:set_font_size(tweak_data.hud_present.text_size - 8)
            invalid_text:set_font_size(tweak_data.hud_present.text_size - 8)
        else
            interact_text:set_font(Idstring("fonts/font_large_mf"))
            invalid_text:set_font(Idstring("fonts/font_large_mf"))
            interact_text:set_font_size(tweak_data.hud_present.text_size - 8)
            invalid_text:set_font_size(tweak_data.hud_present.text_size - 8)
        end
        
        interact_text:set_alpha(0)
        local extra_y = NepgearsyHUDReborn.Options:GetValue("InteractionFont") == 1 and 160 or 144
        interact_text:set_y(self._hud_panel:h() / 2 + extra_y)
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
            color = NepgearsyHUDReborn:GetInteractionColorBySave(),
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
    end)

    NepHook:Post(HUDInteraction, "show_interact", function(self)
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_in"))
    end)

    NepHook:Post(HUDInteraction, "remove_interact", function(self)
        self._hud_panel:child(self._child_name_text):set_visible(true)
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_out"))
    end)

    NepHook:Post(HUDInteraction, "show_interaction_bar", function(self, current, total)
        if self._interact_circle  then
            self._interact_circle :set_visible(false)
        end
        
        self._interact_bar_progress:set_w(0)

        self._interact_bar_contour:animate(callback(self, self, "_animate_fade_in"))
        self._interact_bar_progress:animate(callback(self, self, "_animate_fade_in"))
        self._interact_bar_background:animate(callback(self, self, "_animate_fade_in"))
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_in"))

        self._interact_bar_contour:set_position(self._hud_panel:w() / 2 - (333 / 2), self._hud_panel:h() / 2 + 120)
        self._interact_bar_progress:set_position(self._hud_panel:w() / 2 - (333 / 2), self._hud_panel:h() / 2 + 120)
        self._interact_bar_background:set_position(self._hud_panel:w() / 2 - (333 / 2), self._hud_panel:h() / 2 + 120)
    end)

    NepHook:Post(HUDInteraction, "set_interaction_bar_width", function(self, current, total)
        if self._interact_bar_progress then
            local calc = math.clamp(current / total, 0, 500) * 333

            if calc > 333 then
                calc = 333
            end
            
            self._interact_bar_progress:set_w(calc)
        end
    end)

    function HUDInteraction:hide_interaction_bar(complete)
        self._interact_bar_contour:animate(callback(self, self, "_animate_fade_out"))
        self._interact_bar_progress:animate(callback(self, self, "_animate_fade_out"))
        self._interact_bar_background:animate(callback(self, self, "_animate_fade_out"))
        self._hud_panel:child(self._child_name_text):animate(callback(self, self, "_animate_fade_out"))
    end

    function HUDInteraction:set_bar_valid(valid, text_id)
        if not valid then
            if self._interact_bar_background then
                self._interact_bar_background:set_color(Color.red)
            end
        else
            if self._interact_bar_background then
                self._interact_bar_background:set_color(NepgearsyHUDReborn:GetInteractionColorBySave())
            end
        end

        self._hud_panel:child(self._child_name_text):set_visible(valid)
    
        local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
    
        if text_id then
            invalid_text:set_text(managers.localization:to_upper_text(text_id))
        end
    
        invalid_text:set_visible(not valid)
    end

    function HUDInteraction:_animate_fade_out(o)
        play_value(o, "alpha", 0)
    end

    function HUDInteraction:_animate_fade_in(o)
        play_value(o, "alpha", 1)
    end
end