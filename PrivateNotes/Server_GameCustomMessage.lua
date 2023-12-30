function Server_GameCustomMessage(serverGame, playerID, payload, setReturn)
    -- load playerData
    local playerGameData = Mod.PlayerGameData;
    local playerData = playerGameData[playerID] or {};
    local currentTurn = serverGame.Game.TurnNumber;

    if (payload.changeNewTurnsTopTo ~= nil) then
        -- update setting
        playerData.newTurnsTop = payload.changeNewTurnsTopTo;

        -- save playerData
        playerGameData[playerID] = playerData;
        Mod.PlayerGameData = playerGameData;

        return; -- return early to prevent nested if's
    end

    -- initialize items if they are nil
    if (payload.noteText == nil) then return; end
    if (playerData.notes == nil) then playerData.notes = {}; end
    if (playerData.notes[currentTurn] == nil) then playerData.notes[currentTurn] = {}; end

    -- add the new note to playerData
    table.insert(playerData.notes[currentTurn], payload)
    
    -- save playerData
    playerGameData[playerID] = playerData;
    Mod.PlayerGameData = playerGameData;
end