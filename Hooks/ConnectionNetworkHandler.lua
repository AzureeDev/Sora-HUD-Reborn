NepHook:Post(ConnectionNetworkHandler, "sync_outfit", function(self)
    LuaNetworking:SendToPeers("nephud_teammate_bg", tostring(NepgearsyHUDReborn:GetTeammateSkinID()))
end)