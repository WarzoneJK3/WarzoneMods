function Server_GameCustomMessage(serverGame, playerID, payload, setReturn)

    -- load data
    local playerGameData = Mod.PlayerGameData;
    local data = playerGameData[playerID];
    local currentTurn = serverGame.Game.TurnNumber;


    -- initialize items if they are ne
    if (payload.note == nil) then return; end
    if (data == nil) then data = {}; end
    if (data[currentTurn] == nil) then data[currentTurn] = {}; end


    -- add the new note to data
    table.insert(data[currentTurn], payload.note)
    

    -- save data
    playerGameData[playerID] = data;
    Mod.PlayerGameData = playerGameData;
end