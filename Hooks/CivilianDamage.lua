NepHook:Post(CivilianDamage, "_on_damage_received", function(self, damage_info)
    local attacker_unit = damage_info and damage_info.attacker_unit

    if damage_info.result.type == "death" and attacker_unit == managers.player:player_unit() then
        managers.hud._hud_assault_corner:UpdateCivKilled()
    end
end)
