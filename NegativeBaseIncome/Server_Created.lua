function Server_Created(game, settings)
    local baseIncome = settings.MinimumArmyBonus;

    local data = Mod.PrivateGameData;

    data.Income = -2 * baseIncome;

    Mod.PrivateGameData = data;
end