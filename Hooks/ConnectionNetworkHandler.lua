NepHook:Post(ConnectionNetworkHandler, "sync_outfit", function()
    LuaNetworking:SendToPeers("nephud_teammate_bg", tostring(NepgearsyHUDReborn:GetOption("TeammateSkin")))

    if NepgearsyHUDReborn:GetOption("EnableStarring") then
        if NepgearsyHUDReborn:GetOption("StarringColor") ~= 1 then
            LuaNetworking:SendToPeers("StarringColor", tostring(NepgearsyHUDReborn:GetOption("StarringColor")))
        end
        if tostring(NepgearsyHUDReborn:GetOption("StarringText")) ~= "" then
            LuaNetworking:SendToPeers("StarringText", tostring(NepgearsyHUDReborn:GetOption("StarringText")))
        end
    end
end)