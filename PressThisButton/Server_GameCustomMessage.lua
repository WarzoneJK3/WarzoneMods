function Server_GameCustomMessage(Game,PlayerID,payload,setReturn)
    -- load data
    playerGameData = Mod.PlayerGameData;
    data = playerGameData[PlayerID];
    if (data == nil) then data={}; end
    if (payload.msg==nil) then payload.msg=""; end
    
    -- check msg
    if payload.msg == "InitialPopupDisplayed" then
        data.InitialPopupDisplayed = true;
        if (Game.Game.PlayingPlayers[PlayerID]~=nil) then
            data.isPlayer=true;
        end
    elseif payload.msg=="ClickButton" then
        data.btnPressed = true;
    elseif payload.msg=="WarningSeen" then
        data.showWarning = false;
    end
    
    -- save data
    playerGameData[PlayerID] = data;
    Mod.PlayerGameData = playerGameData;

end