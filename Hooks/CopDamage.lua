NepHook:Post(CopDamage, "damage_bullet", function(self, attacker_data)

    local is_civilian = CopDamage.is_civilian(self._unit:base()._tweak_table)

    if is_civilian then
        managers.hud._hud_assault_corner:UpdateCivKilled()
    end
end)