-- NOTE for all future readers:
-- the (A and B or C) logic is equivelent to (A ? B : C)

function applyIncomeModifiers(game, standing, addOrderImpl)
    print("--------------- Turn "..game.Game.TurnNumber.." --------------")

    -- load settings
    useOddNumber = Mod.Settings.UseOddNumber;
    useTeams = Mod.Settings.UseTeams and Mod.PublicGameData.IsTeamGame;
    usePercent = Mod.Settings.UsePercent;
    percentToRemove = Mod.Settings.PercentToRemove;
    armiesToRemove = Mod.Settings.ArmiesToRemove;

    -- configure messages
    local oddEvenString = (useOddNumber and "odd" or "even");
    local teamsString = (useTeams and "your team" or "you");
    local amountString = (usePercent and tostring(percentToRemove).."%" or tostring(armiesToRemove));

    local orderMsg = "Removing "..amountString.." income due to an "..oddEvenString.." number of territories";
    local incomeMsg = "Due to "..teamsString.." owning an "..oddEvenString.." number of territories";

    -- count number of terr per player or team
    local territoryCount = {};
    local playerToTeam = {};
    local teamToPlayers = {};

    for id, player in pairs(game.Game.PlayingPlayers) do
        if (useTeams) then
            if teamToPlayers[player.Team] == nil then
                teamToPlayers[player.Team] = {};
            end
            table.insert(teamToPlayers[player.Team], id);
            playerToTeam[id] = player.Team;
            territoryCount[player.Team] = 0;
        else
            territoryCount[id] = 0;
        end
    end

    for _, terr in pairs(standing.Territories) do
        if (not terr.IsNeutral) then
            local key = (useTeams and playerToTeam[terr.OwnerPlayerID] or terr.OwnerPlayerID);
            territoryCount[key] = territoryCount[key] + 1
        end
    end

    -- add income modifiers
    for id, count in pairs(territoryCount) do
        local isEvenCount = count % 2 == 0
        print((useTeams and "Team" or "Player").." "..id.." = "..count.." / "..(isEvenCount and "even" or "odd"))

        if ((useOddNumber and isEvenCount) or (not useOddNumber and not isEvenCount)) then
            -- skip if right amount of territories
            print("Skipping "..id)
            goto continue;
        end

        print("Removing income from "..id)
        if (useTeams) then
            local incomeModArray = {};

            for _, pid in pairs(teamToPlayers[id]) do
                local incomeMod = WL.IncomeMod.Create(pid, -incomeToRemove(game, standing, pid), incomeMsg);
                table.insert(incomeModArray, incomeMod);
            end
            addOrderImpl(teamToPlayers[id], orderMsg, incomeModArray);
        else
            local incomeMod = WL.IncomeMod.Create(id, -incomeToRemove(game, standing, id), incomeMsg);
            addOrderImpl({id}, orderMsg, {incomeMod});
        end

        ::continue::
    end
end

-- function addOrderImpl(playerIds, orderMessage, incomeMods)

function incomeToRemove(game, standing, playerID)
    if (usePercent) then
        player = game.Game.PlayingPlayers[playerID];
        income = player.Income(0, standing, false, false).Total;
        return income * percentToRemove / 100;
    else
        return armiesToRemove;
    end
end
