function Server_GameCustomMessage(Game, PlayerID, payload, setReturn)
    -- load data
    local playerGameData = Mod.PlayerGameData;
    local data = playerGameData[PlayerID];
    if (data == nil) then data={}; end
    if (payload.msg==nil) then payload.msg=""; end
    
    -- check msg
    if payload.msg=="WarningSeen" then
        data.showWarning = false;
    end
    
    -- save data
    playerGameData[PlayerID] = data;
    Mod.PlayerGameData = playerGameData;
end