function Server_StartGame(game, standing) 
    local publicData = Mod.PublicGameData;

    -- this just checks if it a team game, since there is no acutal setting for it
    publicData.IsTeamGame = true;
    for id, player in pairs(game.ServerGame.Game.Players) do
        if (player.Team == -1) then
            publicData.IsTeamGame = false;
            break;
        end
    end 

    Mod.PublicGameData = publicData;
end