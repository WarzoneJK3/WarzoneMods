function Client_GameRefresh(game)
    if (game.Us == nil) then return; end -- dont show popups for spectators, since PlayerGameData isnt available for them, so popup cant be disabled

    local data = Mod.PlayerGameData;
    
	if (not data.InitialPopupDisplayed ) then
        UI.Alert("This game includes the Press This Button mod. If you dont press the button your income will be reduced by "..Mod.Settings.ReducePercent..'% next turn.')
        game.SendGameCustomMessage("Updating server, please wait... ", {msg = "InitialPopupDisplayed"}, function(reply)end);
	end
    
    if  (data.showWarning == nil) then data.showWarning=false; end
    if (data.warningMessage == nil) then data.warningMessage=""; end
    
    if (data.showWarning and Mod.Settings.PopupWarning) then
        UI.Alert(data.warningMessage);
        game.SendGameCustomMessage("Updating server, please wait... ", {msg="WarningSeen"}, function(reply)end);
    end
end