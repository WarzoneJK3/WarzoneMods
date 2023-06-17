function Client_PresentSettingsUI(rootParent)
    -- load settings
    useOddNumber = Mod.Settings.UseOddNumber;
    useTeams = Mod.Settings.UseTeams; 
    usePercent = Mod.Settings.UsePercent;
    percentToRemove = Mod.Settings.PercentToRemove;
    armiesToRemove = Mod.Settings.ArmiesToRemove;

    -- configure messages
    oddEvenString = (useOddNumber and "odd" or "even");
    teamsString = (useTeams and "team" or "player");
    amountString = (usePercent and tostring(percentToRemove).."%" or tostring(armiesToRemove))

    -- setup layout
    vert = UI.CreateVerticalLayoutGroup(rootParent);
    UI.CreateLabel(vert).SetText("Removing "..amountString.." income when a "..teamsString.." owns an "..oddEvenString.." number of territories.");
    if (useOddNumber) then
        UI.CreateLabel(vert).SetColor("#23A0FF").SetText("Note: Turn 1 income cannot be removed due to Warzone limitations.");
    end
end