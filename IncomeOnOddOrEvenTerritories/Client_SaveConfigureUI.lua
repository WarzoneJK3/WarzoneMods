function Client_SaveConfigureUI(alert)

    Mod.Settings.UseOddNumber = oddCheckbox.GetIsChecked();
    Mod.Settings.UseTeams = teamsCheckbox.GetIsChecked();
    Mod.Settings.UsePercent = percentCheckbox.GetIsChecked();

    if (Mod.Settings.UsePercent) then
        local percentToRemove = percentSlider.GetValue();
        if (percentToRemove==nil or percentToRemove <= 0 or percentToRemove > 100) then 
            alert('% to remove not set properly')
        else
            Mod.Settings.PercentToRemove = percentToRemove;  -- TO DO : round this properly 
        end
    else
        local armiesToRemove = tonumber(armiesTextfield.GetText());
        if (armiesToRemove == nil or armiesToRemove < 1) then
            alert('Income to remove must be set to a valid number') 
        else
            Mod.Settings.ArmiesToRemove = armiesToRemove;
        end
    end
end
