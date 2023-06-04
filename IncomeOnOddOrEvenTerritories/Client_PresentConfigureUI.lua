function Client_PresentConfigureUI(rootParent)
    vert = UI.CreateVerticalLayoutGroup(rootParent);
    
    -- load initial values 
    useOddNumber = Mod.Settings.UseOddNumber;
    if (useOddNumber == nil) then useOddNumber = true; end

    useTeams = Mod.Settings.UseTeams;
    if (useTeams == nil) then useTeams = true; end

    removeIncomeByPercent = Mod.Settings.UsePercent;
    if (removeIncomeByPercent == nil) then removeIncomeByPercent = true; end

    percentToRemove = Mod.Settings.PercentToRemove;
    if (percentToRemove == nil) then percentToRemove = 100; end

    armiesToRemove = Mod.Settings.ArmiesToRemove;
    if (armiesToRemove == nil) then armiesToRemove = 9999; end


    -- create explainer
    UI.CreateLabel(vert).SetText("This mods removes the income of players/teams based on the number of territories that they own.");
    UI.CreateLabel(vert).SetText("If you want to always remove all income, disable 'Remove income by %' and set 'Income to remove' to a very high value.");
    UI.CreateLabel(vert).SetText("(This is needed due to the unknown order in which mods execute.)");
    UI.CreateEmpty(vert).SetPreferredHeight(15);


    -- create checkbox settings
    oddCheckbox = UI.CreateCheckBox(vert)
        .SetText('Use odd number of territories (otherwise use even)')
        .SetIsChecked(useOddNumber)
        .SetPreferredHeight(25);

    teamsCheckbox = UI.CreateCheckBox(vert)
        .SetText('Use team total whenever possible')
        .SetIsChecked(useTeams)
        .SetPreferredHeight(25);

    percentCheckbox = UI.CreateCheckBox(vert)
        .SetText('Remove income by %')
        .SetIsChecked(removeIncomeByPercent)
        .SetPreferredHeight(25)
        .SetOnValueChanged(togglePercent);
    
    -- create income to remove settings 
    horiz = UI.CreateHorizontalLayoutGroup(vert).SetFlexibleWidth(1).SetPreferredHeight(25);
    incomeLabel = UI.CreateLabel(horiz).SetText('Income to remove ').SetPreferredHeight(25);
    togglePercent();
end

function togglePercent()
    if (percentCheckbox.GetIsChecked()) then
        if (not UI.IsDestroyed(armiesTextfield)) then UI.Destroy(armiesTextfield) end;

        percentSlider = UI.CreateNumberInputField(horiz)
            .SetPreferredHeight(25)
            .SetFlexibleWidth(1)
            .SetWholeNumbers(false)
            .SetBoxPreferredWidth(45)
            .SetSliderPreferredWidth(250)
            .SetSliderMinValue(1)
            .SetSliderMaxValue(100)
            .SetValue(percentToRemove);
    else
        if (not UI.IsDestroyed(percentSlider)) then UI.Destroy(percentSlider) end;

        armiesTextfield = UI.CreateTextInputField(horiz)
            .SetPreferredHeight(25)
            .SetFlexibleWidth(1)
            .SetPlaceholderText(" Numbers only!")
            .SetText(tostring(armiesToRemove));
    end
end