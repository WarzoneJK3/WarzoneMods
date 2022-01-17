function Client_PresentSettingsUI(rootParent)   
    vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('If the button is not pressed, player income is reduced by '..Mod.Settings.ReducePercent..'% the next turn.');
    UI.CreateLabel(vert).SetText('Popup warning when user failed to press the button: '..YesOrNo(Mod.Settings.PopupWarning)..'.');
end

function YesOrNo(bool)
    if bool then
        return "Yes";
    else
        return "No";
     end
end