NepHook:Post(GroupAIStateBesiege, "_upd_recon_tasks", function(self)
    local assault_corner = managers.hud._hud_assault_corner

    if not managers.hud._hud_assault_corner._assault and not managers.hud._hud_assault_corner._point_of_no_return then
        assault_corner:_update_assault_hud_color(assault_corner._assault_survived_color)
    end
end)