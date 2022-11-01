function Server_Created(game, settings)
    local baseIncome = settings.MinimumArmyBonus;
    local data = Mod.PrivateGameData;

    settings.MinimumArmyBonus = 0;
    data.Income = -baseIncome;

    Mod.PrivateGameData = data;
end