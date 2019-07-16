NepHook:Post(StatisticsManager, "killed", function(self)
    managers.hud._hud_assault_corner:IncreaseTotalKillsSession()

    local total_killed = managers.hud._hud_assault_corner.totalKilledSession

    if NepgearsyHUDReborn:IsKillTrackerPresence() then
        NepgearsyHUDReborn:SetDiscordPresence("/// Killing in Progress ///", total_killed .. " kills", true, false)
    end
end)