function Server_AdvanceTurn_End(game,addOrder)
    -- NOTE for all future readers:
    -- the (A and B or C) logic is equivelent to (A ? B : C)
    print("--------------- Turn "..game.Game.TurnNumber.." --------------")

    -- load settings
    useOddNumber = Mod.Settings.UseOddNumber;
    useTeams = Mod.Settings.UseTeams and Mod.PublicGameData.IsTeamGame; 
    usePercent = Mod.Settings.UsePercent;
    percentToRemove = Mod.Settings.PercentToRemove;
    armiesToRemove = Mod.Settings.ArmiesToRemove;


    -- configure messages
    oddEvenString = (useOddNumber and "odd" or "even");
    teamsString = (useTeams and "your team" or "you");
    amountString = (usePercent and tostring(percentToRemove).."%" or tostring(armiesToRemove))

    orderMsg = "Removing "..amountString.." income due to "..oddEvenString.." number of territories";
    incomeMsg = "Due to "..teamsString.." owning an "..oddEvenString.." number of territories";


    -- count number of terr per player or team
    territoryCount = {};
    playerToTeam = {};
    teamToPlayers = {};

    for id, player in pairs(game.Game.PlayingPlayers) do
        if (useTeams) then
            if teamToPlayers[player.Team] == nil then teamToPlayers[player.Team] = {}; end
            table.insert(teamToPlayers[player.Team], id);
            playerToTeam[id] = player.Team;
            territoryCount[player.Team] = 0;
        else
            territoryCount[id] = 0;
        end
    end

    for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
        if (not terr.IsNeutral) then
            key = (useTeams and playerToTeam[terr.OwnerPlayerID] or terr.OwnerPlayerID);
            territoryCount[key] = territoryCount[key] + 1
        end
    end


    -- add income modifiers
    for id, count in pairs(territoryCount) do
        local isEvenCount = count % 2 == 0
        print((useTeams and "team" or "player").." ["..id.."] = "..count.." / "..(isEvenCount and "even" or "odd"))
        if (useOddNumber and isEvenCount or not useOddNumber and not isEvenCount) then
            print("Skipping "..id)
            -- skip if right amount of territories
            goto continue;
        end
        print("Removing income from "..id)
        if (useTeams) then
            incomeModArray = {};
            
            for _, pid in pairs(teamToPlayers[id]) do
                incomeMod = WL.IncomeMod.Create(pid, -incomeToRemove(game, pid), incomeMsg);
                table.insert(incomeModArray, incomeMod);
            end
            addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, orderMsg, teamToPlayers[id], nil, nil, incomeModArray));
        else
            incomeMod = WL.IncomeMod.Create(id, -incomeToRemove(game, id), incomeMsg);
            addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, orderMsg, {id}, nil, nil, {incomeMod}));
        end

        ::continue::
    end

end

function incomeToRemove(game, playerID)
    if (usePercent) then
        player = game.Game.PlayingPlayers[playerID];
        income = player.Income(0, game.ServerGame.LatestTurnStanding, false, false).Total;
        return income * percentToRemove / 100;
    else
        return armiesToRemove;
    end
end