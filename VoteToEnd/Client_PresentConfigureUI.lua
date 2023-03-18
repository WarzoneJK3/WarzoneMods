function Client_PresentConfigureUI(rootParent)
  -- set initial value to whatever is stored, or 33% if nothing is stored
  local initialPercent = Mod.Settings.PercentPlayers;
  local initialTurns = Mod.Settings.WarningTurns
  if (initialPercent == nil) then initialPercent = 66; end;
  if (initialTurns == nil) then initialTurns = 3; end;
  
  -- create vertical element to add settings to
  vert = UI.CreateVerticalLayoutGroup(rootParent);
  horz = UI.CreateHorizontalLayoutGroup(vert);
  
  -- Set % of players
  UI.CreateLabel(horz).SetText('% of players that needs to VTE');
  percentInputField = UI.CreateNumberInputField(horz)
  .SetSliderMinValue(51)
  .SetSliderMaxValue(100)
  .SetValue(initialPercent);

  -- Set number of turns for warning
  UI.CreateLabel(horz).SetText('Number of turns a player has to VTE after the voting treshold is passed');
  turnsInputField = UI.CreateNumberInputField(horz)
  .SetSliderMinValue(1)
  .SetSliderMaxValue(10)
  .SetValue(initialTurns);
end