function Client_SaveConfigureUI(alert)
    -- get value from slider element
    local percents = percentInputField.GetValue();
    local turns = turnsInputField.GetValue();
    
    -- check if values are within bounds
    if (percents==nil or percents <= 50 or percents > 100) then 
        alert('"% of players" must be set between 51 and 100'); 
    else 
        Mod.Settings.PercentPlayers = percents
    end

    if (turns==nil or turns < 1) then
       alert('"Number of turns" must be set') 
    else
        Mod.Settings.WarningTurns = turns
    end
end
