NepHook:Post(ChatManager, "init", function(self)
    self._player_steam_id = {}
end)

NepHook:Post(ChatManager, "receive_message_by_peer", function(self, channel_id, peer, message)
    self._player_steam_id = self._player_steam_id or {}
    self._player_steam_id[peer:id()] = peer:account_id()
end)