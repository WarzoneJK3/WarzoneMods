function Client_PresentConfigureUI(rootParent)
    -- set initial value to whatever is stored, or 33% if nothing is stored
    local initialValue = Mod.Settings.ReducePercent;
    if (initialValue == nil) then initialValue = 33; end;
    
    -- create a slider element
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('Reduce player income by (%)');
    numberInputField = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(100)
		.SetValue(initialValue);

end