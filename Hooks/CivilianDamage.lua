NepHook:Post(CivilianDamage, "die", function(self, variant)
    managers.hud._hud_assault_corner:UpdateCivKilled()
end)
