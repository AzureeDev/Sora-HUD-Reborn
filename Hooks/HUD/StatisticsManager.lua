NepHook:Post(StatisticsManager, "killed", function(self)
    managers.hud._hud_assault_corner:IncreaseTotalKillsSession()
end)