function Server_AdvanceTurn_End(game, addNewOrder)
    -- update turn number on server side, so that client can keep its window open at all times
    -- (since clientGame object only updates when the window reopens)
    local publicGameData = Mod.PublicGameData;
    publicGameData.turnNumber = game.Game.TurnNumber + 1;
    Mod.PublicGameData = publicGameData;
end