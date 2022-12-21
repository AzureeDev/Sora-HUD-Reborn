if NepgearsyHUDReborn:HasInteractionEnabled() then
    function HUDManager:pd_start_progress(current, total, msg, icon_id)
        local hud = self:script(PlayerBase.PLAYER_DOWNED_HUD)

        if not hud then
            return
        end

        self._pd2_hud_interaction = HUDInteraction:new(managers.hud:script(PlayerBase.PLAYER_DOWNED_HUD))

        self._pd2_hud_interaction:show_interact({text = utf8.to_upper(managers.localization:text(msg))})
        self._pd2_hud_interaction:show_interaction_bar(current, total)
        self._hud_player_downed:hide_timer()

        local function feed_circle(o, total)
            local t = 0

            while t < total do
                t = t + coroutine.yield()

                self._pd2_hud_interaction:set_interaction_bar_width(t, total)
            end
        end

        if _G.IS_VR then
            return
        end

        self._pd2_hud_interaction._interact_bar_progress:set_alpha(0)
        self._pd2_hud_interaction._interact_bar_progress:animate(feed_circle, total)
    end
end