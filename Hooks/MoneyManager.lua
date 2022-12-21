NepHook:Post(MoneyManager, "_setup", function(self)
    self._civilian_killed_reduction = 0
end)

NepHook:Post(MoneyManager, "civilian_killed", function(self)
    self._civilian_killed_reduction = self._civilian_killed_reduction + self:get_civilian_deduction()
end)

function MoneyManager:get_civilian_reduction()
    return self._civilian_killed_reduction
end