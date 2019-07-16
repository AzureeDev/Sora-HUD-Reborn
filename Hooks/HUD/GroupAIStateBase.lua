NepHook:Post(GroupAIStateBase, "convert_hostage_to_criminal", function(self, unit, peer_unit)
    local player_unit = managers.player:player_unit()

    if not alive(player_unit) then
        return
    end

    if player_unit ~= peer_unit then
        return
    end

    local real_health = player_unit:character_damage():get_real_health() * (player_unit:base():upgrade_level("player", "passive_convert_enemies_health_multiplier") or 1)
    player_unit:character_damage():set_health(real_health)
end)