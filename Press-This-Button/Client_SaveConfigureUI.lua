function Client_SaveConfigureUI(alert)
    -- get value from slider element
    Mod.Settings.ReducePercent = numberInputField.GetValue();
    
    -- check if value is within bounds
    if (Mod.Settings.ReducePercent < 1 or Mod.Settings.ReducePercent > 100 or Mod.Settings.ReducePercent==nil) then 
        alert('"Reduce player income by" must be set between 1 and 100'); 
    end
    
    print("Current income reduction"..Mod.Settings.ReducePercent);
end