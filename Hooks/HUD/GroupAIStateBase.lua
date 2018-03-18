NepHook:Post(GroupAIStateBesiege, "_upd_recon_tasks", function(self)
    local assault_corner = managers.hud._hud_assault_corner
    local box_text_panel = assault_corner._assault_panel_v2:child("text_panel")
    if not managers.hud._hud_assault_corner._assault and not managers.hud._hud_assault_corner._point_of_no_return then
        assault_corner:_update_assault_hud_color(assault_corner._assault_survived_color)
        assault_corner:_start_assault(assault_corner:_get_incoming_textlist())
    end
end)