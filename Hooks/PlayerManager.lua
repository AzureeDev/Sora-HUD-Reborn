NepHook:Post(PlayerManager, "init", function(self)
    self._player_teammate_bgs = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1
    }
end)

NepHook:Post(PlayerManager, "peer_dropped_out", function(self, peer)
    self._player_teammate_bgs[peer:id()] = 1 -- Clean bg on peer drop
end)