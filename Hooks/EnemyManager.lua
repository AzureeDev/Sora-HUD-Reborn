NepHook:Post(EnemyManager, "register_enemy", function(self, enemy)
    if managers and managers.hud and managers.hud._hud_assault_corner then
        managers.hud._hud_assault_corner:_update_cops_map(1)
    end
end)

NepHook:Post(EnemyManager, "on_enemy_unregistered", function(self, unit)
    if managers and managers.hud and managers.hud._hud_assault_corner then    
        managers.hud._hud_assault_corner:_update_cops_map(-1)
    end
end)