function Client_PresentSettingsUI(rootParent)
    local percent = Mod.Settings.PercentPlayers;
    local turns = Mod.Settings.WarningTurns;

    local vert = UI.CreateVerticalLayoutGroup(rootParent);
    UI.CreateLabel(vert).SetText('After '..percent..'% of players VTE, the remaining players have '..turns..' turns to VTE before being eliminated.');
end