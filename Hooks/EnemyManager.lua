NepHook:Post(EnemyManager, "register_enemy", function(self, enemy)
    managers.hud._hud_assault_corner:_update_cops_map(1)
end)

NepHook:Post(EnemyManager, "on_enemy_unregistered", function(self, unit)
    managers.hud._hud_assault_corner:_update_cops_map(-1)
end)