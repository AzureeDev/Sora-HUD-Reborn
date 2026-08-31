-- jfc ovk
if NepgearsyHUDReborn:GetOption("EnableSteamAvatarsInLobby") then
	NepHook:Post(ContractBoxGui, "create_character_text", function(self, peer_id)
		self._peers_avatars = self._peers_avatars or {}
		self._peers_avatars[peer_id] = self._peers_avatars[peer_id] or self._panel:bitmap({
			w = 40,
			h = 40,
			texture = "guis/textures/pd2/none_icon"
		})
		self._peers_avatars[peer_id]:set_center(self._peers[peer_id]:center())
		self._peers_avatars[peer_id]:set_bottom(self._peers[peer_id]:top())

		local peer = managers.network and managers.network:session() and managers.network:session():peer(peer_id)
		if peer then
			local steam_id = peer:account_id()
			if steam_id then
				NepgearsyHUDReborn:SteamAvatar(steam_id, function(texture)
					if texture then
						self._peers_avatars[peer_id]:set_image(texture)
					end
				end)
			end
		end
	end)
end