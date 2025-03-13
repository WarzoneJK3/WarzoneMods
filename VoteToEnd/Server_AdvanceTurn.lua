require("Annotations");

function Server_AdvanceTurn_Start(game, addOrder)
    -- check that VTE is actually possible
    if (game.Settings.SinglePlayer or game.Settings.IsCoinsGame or game.Settings.IsTournamentLadderQuickmatchOrClanWar) then
        return;
    end

    -- get globals
    local publicData = Mod.PublicGameData
    local playerData = Mod.PlayerGameData
    local currentTurn = game.Game.TurnNumber
    if publicData == nil then publicData = {} end
    if (publicData.turnVotePassed == nil) then publicData.turnVotePassed = -99 end
    if playerData == nil then playerData = {} end

    -- update player data
    local totalPlayers = 0
    local votedPlayers = 0
    local playerVotes = {}

    for playerID, player in pairs(game.Game.PlayingPlayers) do
        if (not player.IsAIOrHumanTurnedIntoAI) then 
            playerVotes[playerID] = false
            totalPlayers = totalPlayers + 1
        end
    end

    for playerID, time in pairs(game.Game.VotedToEndGame) do
        if (playerVotes[playerID] ~= nil) then
            playerVotes[playerID] = true;
            votedPlayers = votedPlayers + 1
        end
    end

    -- process turn
    local percent = Mod.Settings.PercentPlayers
    if (percent == nil) then 
        percent = 0.66
    else 
        percent = percent / 100 
    end

    local neededVotes = math.ceil(totalPlayers * percent)
    local VTEconditionTrue = neededVotes <= votedPlayers
    
    if VTEconditionTrue then
        if (publicData.turnVotePassed < 0) then
            publicData.turnVotePassed = currentTurn
        end
    else
        publicData.turnVotePassed = -99
    end

    -- set temp values for debugging
    publicData.totalPlayers = totalPlayers
    publicData.votedPlayers = votedPlayers
    publicData.playerVotes = playerVotes
    publicData.percent = percent
    publicData.neededVotes = neededVotes
    publicData.condition = VTEconditionTrue

    for playerID, voted in pairs(playerVotes) do
        -- reset stuff
        if (playerData[playerID] == nil) then playerData[playerID] = {} end
        playerData[playerID].showWarning = false
        playerData[playerID].warningMessage = ""

        -- handle vote
        if (VTEconditionTrue and not voted) then
            local turnsPassed = currentTurn - publicData.turnVotePassed
            local turnsRemaining = Mod.Settings.WarningTurns - turnsPassed

            -- more temp values for debugging
            publicData.turnsPassed = turnsPassed
            publicData.turnsRemaining = turnsRemaining

            if (turnsRemaining > 0) then
                playerData[playerID].showWarning = true
                playerData[playerID].warningMessage = "The majority of players wishes to Vote To End. You have "..turnsRemaining.." turns to VTE before you are eliminated."
            else
                local terrMods = {}
                for terrID, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
                    if (terr.OwnerPlayerID  == playerID) then
                        terrMod = WL.TerritoryModification.Create(terrID)
                        terrMod.SetOwnerOpt = WL.PlayerID.Neutral
                        terrMod.SetArmiesTo = game.Settings.InitialNonDistributionArmies
                        toRemove = {}
                        for idx, unit in pairs(terr.NumArmies.SpecialUnits) do
                            table.insert(toRemove, unit.ID)
                        end
                        terrMod.RemoveSpecialUnitsOpt = toRemove
                        table.insert(terrMods, terrMod)
                    end
                end
                local playername = game.Game.Players[playerID].DisplayName(nil, false)
                local msg = playername.." will be eliminted to force a VTE."
                deathOrder =  WL.GameOrderEvent.Create(playerID, msg, nil, terrMods, nil, nil)
                addOrder(deathOrder)
            end
        end
    end

    -- set globals
    Mod.PublicGameData = publicData
    Mod.PlayerGameData = playerData
end