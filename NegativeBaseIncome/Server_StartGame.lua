-- Applies the negative base income to turn 1
function Server_StartGame(game, standing)
    local incomeMods = standing.IncomeMods;

    local baseIncome = -2 * game.Settings.MinimumArmyBonus;
    local incomeMsg = "Negative income mod";
    for _, player in pairs(game.Game.PlayingPlayers) do
        local incomeMod = WL.IncomeMod.Create(player.ID, baseIncome, incomeMsg);
        table.insert(incomeMods, incomeMod);
    end

    standing.IncomeMods = incomeMods;
end
