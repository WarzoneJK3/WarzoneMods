function Client_PresentSettingsUI(rootParent)   
    horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('If the button is not pressed, player income is reduced by (%): '..Mod.Settings.ReducePercent);
end