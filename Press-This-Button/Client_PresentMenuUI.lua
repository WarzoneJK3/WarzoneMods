function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable,Game,close)
    setMaxSize(400,250);
    game = Game;
    
    -------- Load player data from server ------------------
    playerGameData = Mod.PlayerGameData;
    if (playerGameData.timesFailed==nil) then playerGameData.timesFailed=0; end
    if (playerGameData.btnPressed==nil) then playerGameData.btnPressed=false; end
    if (playerGameData.timesFailed==nil) then playerGameData.timesFailed=0; end
    if (playerGameData.isPlayer==nil) then playerGameData.isPlayer=false; end
    ------------ Set usefull vars ----------------------------------------
    turnNumber = game.Game.TurnNumber;
    playerIsPlaying = (game.Us ~= nil) and (game.Us.State == WL.GamePlayerState.Playing)
    
    
    ------- Configure UI --------------------------------------
    -- player is in the game
    if (playerIsPlaying) then
        vert = UI.CreateVerticalLayoutGroup(rootParent);
        text = UI.CreateLabel(vert).SetText('If the button below is not pressed this turn, your income will be reduced by '..Mod.Settings.ReducePercent..'% next turn.\n\n');
        horz = UI.CreateHorizontalLayoutGroup(vert);
        textSpacer = UI.CreateLabel(horz).SetText("‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎")
        -- set up the button with callback to clicked() and make its text bright white
        button = UI.CreateButton(horz)
            .SetOnClick(clicked)
            .SetTextColor("#FFFFFF");
        text1 = UI.CreateLabel(vert).SetText('\nSo far, you failed to press the button '..playerGameData.timesFailed..' times.');
        
        -- assign right colors and label to button
        if (playerGameData.btnPressed) then
            button
                .SetInteractable(false)
                .SetText(" ‏‏‎ ‎‏‏‎‏‏ ‎‏‏You clicked me! ‏‏‎ ‎‏‏‎‏‏‎‏‏‎")
                .SetColor("#00FF00");
        else
            button
                .SetColor("#FF0000")
                .SetText("Press me to survive!")
                .SetInteractable(true);
        end
        
    -- player was in the game during T1, but no longer is    
    elseif (playerGameData.isPlayer) then
        vert = UI.CreateVerticalLayoutGroup(rootParent);
        text = UI.CreateLabel(vert).SetText('If the button below is not pressed this turn, your income will be reduced by '..Mod.Settings.ReducePercent..'% next turn.\n\n');
        horz = UI.CreateHorizontalLayoutGroup(vert);
        textSpacer = UI.CreateLabel(horz).SetText("‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎")
        -- set up the button with callback to clicked() and make its text bright white
        button = UI.CreateButton(horz)
            .SetTextColor("#FFFFFF")
            .SetInteractable(false)
            .SetText("You are not playing.")
             .SetColor("#00FF00");
        text1 = UI.CreateLabel(vert).SetText('\nSo far, you failed to press the button '..playerGameData.timesFailed..' times.');

   -- player is not in the game -> player is spectating
    else
        vert = UI.CreateVerticalLayoutGroup(rootParent);
        text = UI.CreateLabel(vert).SetText('If a player fails to press the button, their income will be reduced by '..Mod.Settings.ReducePercent..'% next turn.\n\n');
        horz = UI.CreateHorizontalLayoutGroup(vert);
        textSpacer = UI.CreateLabel(horz).SetText("‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎")
        button = UI.CreateButton(horz)
                .SetInteractable(false)
                .SetText("You're not a player.")
                .SetColor("#00FF00")  
                .SetTextColor("#FFFFFF");      
    end
end

function clicked()
    -- update button
    button
        .SetInteractable(false)
        .SetText("‎‏‏‎ ‎‏‏‎‏ ‎‏‏‎You clicked me! ‎‏‎ ‎‏‏‎‏ ‎‏‏‎")
        .SetColor("#00FF00");
        
     --send message 
    payload = {};
    payload.msg = "ClickButton"
    game.SendGameCustomMessage("Submitting button press to server...",payload,function(reply) end); --empty callback function
end