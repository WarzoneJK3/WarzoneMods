function Client_GameRefresh(game)
    if (game.Us == nil) then return; end -- dont show popups for spectators, since PlayerGameData isnt available for them, so popup cant be disabled

    local data = Mod.PlayerGameData;
    
    if (data.showWarning == nil) then data.showWarning=false; end
    if (data.warningMessage == nil) then data.warningMessage=""; end
    
    if (data.showWarning) then
        UI.Alert(data.warningMessage);
        game.SendGameCustomMessage("Updating server, please wait... ", {msg="WarningSeen"}, function(reply)end);
    end
end
