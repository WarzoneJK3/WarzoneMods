require("Annotations");

function Server_GameCustomMessage(game, playerID, payload, setReturn)
    -- load data
    local playerGameData = Mod.PlayerGameData;
    local data = playerGameData[playerID];
    if (data == nil) then data = {}; end
    if (payload.msg == nil) then payload.msg = ""; end

    -- check msg
    if payload.msg == "WarningSeen" then
        data.showWarning = false;
    end

    -- save data
    playerGameData[playerID] = data;
    Mod.PlayerGameData = playerGameData;
end