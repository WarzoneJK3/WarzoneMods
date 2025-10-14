require("ModCode");

function Server_StartGame(game, standing) 
    local publicData = Mod.PublicGameData;

    -- this just checks if it a team game, since there is no actual setting for it
    publicData.IsTeamGame = true;
    for id, player in pairs(game.ServerGame.Game.Players) do
        if (player.Team == -1) then
            publicData.IsTeamGame = false;
            break;
        end
    end 

    Mod.PublicGameData = publicData;

    -- apply the income modifiers to turn 1
    local standingIncomeMods = standing.IncomeMods;

    function addOrderImpl(playerIds, orderMessage, incomeMods)
        for _, incomeMod in pairs(incomeMods) do
            table.insert(standingIncomeMods, incomeMod);
        end
    end

    applyIncomeModifiers(game, standing, addOrderImpl);

    standing.IncomeMods = standingIncomeMods;
end

