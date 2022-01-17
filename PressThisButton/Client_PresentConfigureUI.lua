function Client_PresentConfigureUI(rootParent)
    -- set initial value to whatever is stored, or 33% if nothing is stored
    local initialValue = Mod.Settings.ReducePercent;
    local initialTick = Mod.Settings.PopupWarning;
    if (initialValue == nil) then initialValue = 33; end;
    if (initialTick == nil) then initialTick = true; end;
    
    --create vertical element to add settings to
    vert = UI.CreateVerticalLayoutGroup(rootParent);
    -- create a slider element
    horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz).SetText('Reduce player income by (%)');
    numberInputField = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(100)
		.SetValue(initialValue);
    
    -- create toggle box for 
    warningToggle = UI.CreateCheckBox(vert)
        .SetText("Popup a warning to players when they failed to press the button")
        .SetIsChecked(initialTick); 

end