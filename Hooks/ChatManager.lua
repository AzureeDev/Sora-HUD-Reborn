NepHook:Post(ChatManager, "init", function(self)
	self._player_steam_id = {}
	self._player_steam_id[1] = "0"
	self._player_steam_id[2] = "0"
	self._player_steam_id[3] = "0"
	self._player_steam_id[4] = "0"
end)

function ChatManager:receive_message_by_peer(channel_id, peer, message)
	if self:is_peer_muted(peer) then
		return
	end

	local color_id = peer:id()
	local steam_id = peer:user_id()
	local color = tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
	self._player_steam_id[color_id] = steam_id

	self:_receive_message(channel_id, peer:name(), message, tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors], (peer:level() == nil and managers.experience:current_rank() > 0 or peer:rank() > 0) and "infamy_icon")
end