local init_managers_orig = Setup.init_managers
function Setup:init_managers(managers, ...)
    local peer_colors = {
        NepgearsyHUDReborn:GetOption("SoraPeerOneColor"),
        NepgearsyHUDReborn:GetOption("SoraPeerTwoColor"),
        NepgearsyHUDReborn:GetOption("SoraPeerThreeColor"),
        NepgearsyHUDReborn:GetOption("SoraPeerFourColor"),
        NepgearsyHUDReborn:GetOption("SoraAIColor")
    }

    for i, c in ipairs(peer_colors) do
        tweak_data.chat_colors[i] = c
        tweak_data.preplanning_peer_colors[i] = c
    end

    if NepgearsyHUDReborn:GetOption("UseDiscordRichPresence") then
        NepgearsyHUDReborn:DebugLog("Setting up Custom Discord Rich Presence")
        Discord:init("597345010656215041")
    else
        NepgearsyHUDReborn:DebugLog("User disabled Custom Rich Presence, skip")
    end

    init_managers_orig(self, managers, ...)
end