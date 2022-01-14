function Client_GameRefresh(game)
    firstTurn = not (game.Game.TurnNumber > 1 or (game.Game.TurnNumber == 1 and not game.Settings.AutomaticTerritoryDistribution))

	if game.Us == nil or (not Mod.PlayerGameData.InitialPopupDisplayed ) then
        UI.Alert("This game includes the Press This Button mod. If you dont press the button your income will be reduced by "..Mod.Settings.ReducePercent..'% next turn.\nPlease note that this also applies to turn 0 (distribution)!')
		if (game.Us ~= nil) then
            payload = {};
            payload.msg = "InitialPopupDisplayed";
            game.SendGameCustomMessage("Updating server, please wait... ", payload, function(reply)end);
         end
	end
end