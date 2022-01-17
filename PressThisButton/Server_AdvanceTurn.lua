function Server_AdvanceTurn_End(game,addOrder)
    -- load player data from server
    local playerGameData = Mod.PlayerGameData;
    
    -- big ass for loop for checking all players that are still playing
    for _, player in pairs(game.Game.PlayingPlayers) do
    
        -- if players are not a human (anymore), they cant press the button, so keep their income
        if (not player.IsAIOrHumanTurnedIntoAI) then
        
            -- load data for specific player
            local data = playerGameData[player.ID];
            if (data==nil) then data = {}; end
            
            -- check if they failed to press the button
            if (data.btnPressed==nil) then data.btnPressed=false; end
            if (not data.btnPressed) then
            
                -- get current income and calculate how much needs to be removed
                local income = player.Income(0, game.ServerGame.LatestTurnStanding, false, false).Total;
                local incomeDelete = income * Mod.Settings.ReducePercent / 100 * -1;
                incomeDelete = math.ceil(incomeDelete-0.5); -- round float to int
                
                -- create the order to remove the income
                local orderMsg = "Failed to press The Button: "..incomeDelete.." income.";
                local incomeMsg = "You failed to press The Button, you lost "..Mod.Settings.ReducePercent.."% of your income"; 
                local incomeMod = WL.IncomeMod.Create(player.ID, incomeDelete, incomeMsg);
                addOrder(WL.GameOrderEvent.Create(player.ID, orderMsg, {}, {}, nil, {incomeMod}));
                
                -- update player data when failed
                if (data.timesFailed==nil) then data.timesFailed=0; end
                data.timesFailed = data.timesFailed + 1;
                data.showWarning = true;                
                data.warningMessage = "You failed to press The Button, you lost "..Mod.Settings.ReducePercent.."% of your income: "..incomeDelete.." armies per turn";   
            end
            
            -- reset this players button
            data.btnPressed = false;
            playerGameData[player.ID] = data;
        end 
    end
    
    -- save playerGameData
    Mod.PlayerGameData = playerGameData
    
end