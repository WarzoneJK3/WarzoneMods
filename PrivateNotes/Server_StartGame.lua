function Server_StartGame(game, standing)
    -- update turn number on server side, so that client can keep its window open at all times
    -- (since clientGame object only updates when the window reopens)
    local publicGameData = Mod.PublicGameData;
    publicGameData.turnNumber = 1;
    Mod.PublicGameData = publicGameData;
end