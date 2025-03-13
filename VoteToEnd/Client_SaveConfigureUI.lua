require("Annotations");

function Client_SaveConfigureUI(alert)
    -- get value from slider element
    local percents = percentInputField.GetValue();
    local turns = turnsInputField.GetValue();
    
    -- check if values are within bounds
    if (percents < 50 or percents > 100 or percents == nil) then 
        alert("\"% of players\" must be set between 50 and 100"); 
    else 
        Mod.Settings.PercentPlayers = percents
    end

    if (turns < 1 or turns == nil) then
       alert("\"Number of turns\" must be set") 
    else
        Mod.Settings.WarningTurns = turns
    end
end