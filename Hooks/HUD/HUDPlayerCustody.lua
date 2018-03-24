NepHook:Post(HUDPlayerCustody, "set_trade_delay", function(self, time)
    managers.hud._hud_assault_corner:UpdateCivKilledTimer(time)
end)