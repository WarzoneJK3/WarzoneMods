function Server_AdvanceTurn_End(game, addOrder)
    local baseIncome = Mod.PrivateGameData.Income;
    if (baseIncome == nil) then baseIncome = -5 end;

    local incomeMsg = "Negative income mod";
    local incomes = {};
    for _, player in pairs(game.Game.PlayingPlayers) do
        local incomeMod = WL.IncomeMod.Create(player.ID, baseIncome, incomeMsg);
        table.insert(incomes, incomeMod);
    end
    addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, incomeMsg, {}, {}, nil, incomes));
end