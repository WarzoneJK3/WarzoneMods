function Client_SaveConfigureUI(alert)
    -- get value from slider element
    Mod.Settings.ReducePercent = numberInputField.GetValue();
    Mod.Settings.PopupWarning = warningToggle.GetIsChecked();
    
    -- check if value is within bounds
    if (Mod.Settings.ReducePercent==nil or Mod.Settings.ReducePercent < 1 or Mod.Settings.ReducePercent > 100) then 
        alert('"Reduce player income by" must be set between 1 and 100'); 
    end
end
