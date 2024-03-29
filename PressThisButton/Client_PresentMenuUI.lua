function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable,Game,close)
    setMaxSize(400,250); --width and height 
    game = Game; --needed to be able to call game.SendMessage 
    
    -------- Load player data from server ------------------
    local playerGameData = Mod.PlayerGameData;
    if (playerGameData.timesFailed==nil) then playerGameData.timesFailed=0; end
    if (playerGameData.btnPressed==nil) then playerGameData.btnPressed=false; end
    if (playerGameData.timesFailed==nil) then playerGameData.timesFailed=0; end
    if (playerGameData.isPlayer==nil) then playerGameData.isPlayer=false; end
    ------------ Set usefull vars ----------------------------------------
    local playerIsPlaying = (game.Us ~= nil) and (game.Us.State == WL.GamePlayerState.Playing);
    local distributionOver = game.Game.TurnNumber > 0 
    
    ------- Configure UI --------------------------------------
    red = "#FF0000"
    green = "#00FF05"
    vert = UI.CreateVerticalLayoutGroup(rootParent);
    -- explainer of mod and settings
    explainer = UI.CreateLabel(vert).SetText('If the button below is not pressed this turn, your income will be reduced by '..Mod.Settings.ReducePercent..'% next turn.\n\n');
    -- line with button
    horz = UI.CreateHorizontalLayoutGroup(vert);
    btnSpacer = UI.CreateEmpty(horz).SetPreferredWidth(70);
    button = UI.CreateButton(horz)
                .SetOnClick(clicked)
                .SetTextColor("#FFFFFF")
                .SetInteractable(false)
                .SetPreferredWidth(200);
    -- show history to users            
    historyLine = UI.CreateLabel(vert).SetText('\nSo far, you failed to press the button '..playerGameData.timesFailed..' times.');            
     
    ---------- Set appripriate properties for the button -------------------------
    -- player is in the game
    if (playerIsPlaying) then       
        -- remove button during picks
        if (distributionOver) then
            -- assign right colors and label to button
            if (playerGameData.btnPressed) then
                button
                    .SetText("‎‏‏You clicked me!")
                    .SetColor(green);
            else
                button
                    .SetColor(red)
                    .SetText("Press me to survive!")
                    .SetInteractable(true);
            end
        else
            button
                .SetColor(red)
                .SetText("Not during picking...")
        end
        
    -- player was in the game during T1, but no longer is    
    elseif (playerGameData.isPlayer) then
        button
            .SetText("You are not playing")
            .SetColor(green);

   -- player is not in the game -> player is spectating
    else
        button
            .SetText("You're not a player.")
            .SetColor(green);   
        UI.Destroy(historyLine) -- remove history line if player doesnt have history
    end
end

function clicked()
    -- update button
    button
        .SetInteractable(false)
        .SetText("‎‏‏You clicked me!")
        .SetColor(green);
        
     --send message 
    game.SendGameCustomMessage("Submitting button press to server...",{msg = "ClickButton"},function(reply) end); --empty callback function
end