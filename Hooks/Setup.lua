Hooks:PreHook(Setup, "init_managers", "post_hook_init_managers_sora_hud", function(self, managers)
	local SoraHUD = NepgearsyHUDReborn

    tweak_data.chat_colors[1] = SoraHUD:GetOption("SoraPeerOneColor")
    tweak_data.chat_colors[2] = SoraHUD:GetOption("SoraPeerTwoColor")
    tweak_data.chat_colors[3] = SoraHUD:GetOption("SoraPeerThreeColor")
    tweak_data.chat_colors[4] = SoraHUD:GetOption("SoraPeerFourColor")
    tweak_data.chat_colors[5] = SoraHUD:GetOption("SoraAIColor")

    tweak_data.preplanning_peer_colors[1] = SoraHUD:GetOption("SoraPeerOneColor")
    tweak_data.preplanning_peer_colors[2] = SoraHUD:GetOption("SoraPeerTwoColor")
    tweak_data.preplanning_peer_colors[3] = SoraHUD:GetOption("SoraPeerThreeColor")
    tweak_data.preplanning_peer_colors[4] = SoraHUD:GetOption("SoraPeerFourColor")
    tweak_data.preplanning_peer_colors[5] = SoraHUD:GetOption("SoraAIColor")
	
	if not NepgearsyHUDReborn:GetOption("UseDiscordRichPresence") then
		NepgearsyHUDReborn:Log("User disabled Custom Rich Presence, skip init of new app ID.")
		return
    end
    
    log("Init Discord new App")
    Discord:init("597345010656215041")
end)
