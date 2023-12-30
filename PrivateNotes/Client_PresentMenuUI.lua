function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, clientGame, close, calledFromCode)
    -- make clientgame functions global (we will need it later)
    sendMessage = clientGame.SendGameCustomMessage;
    highlightTerritories = clientGame.HighlightTerritories;


    -- create main element
    setMaxSize(500,650);
    vert = UI.CreateVerticalLayoutGroup(rootParent).SetFlexibleWidth(1);
    newNotesGroup = UI.CreateVerticalLayoutGroup(vert).SetFlexibleWidth(1);

    -- get player state
    state = clientGame.Us and clientGame.Us.State or 0 
    canViewNotes = (state >= 2 and state <= 4) or (state >= 7 and state <= 9); -- check is player is or has played in the game
    canAddNotes = (state == WL.GamePlayerState.Playing);

    -- abort if not playing in game
    if (not canViewNotes) then
        UI.CreateLabel(vert).SetText("You can only use notes when playing in this game.");
        return;
    end

    -- load data (and init if needed)
    notes = Mod.PlayerGameData.notes or {};
    newTurnsTop = Mod.PlayerGameData.newTurnsTop or true;

    -- construct the existing notes
    makeNotesList();

    -- build the user input elements
    placeholderText = (canAddNotes and " Add notes here. Use \\n to insert a new line.") or " Cannot add notes.";
    textField = UI.CreateTextInputField(newNotesGroup)
        .SetPlaceholderText(placeholderText)
        .SetInteractable(canAddNotes)
        .SetFlexibleWidth(1)
        .SetPreferredHeight(25);

    locationContainer = UI.CreateHorizontalLayoutGroup(newNotesGroup).SetFlexibleWidth(1);

    buttonContainer = UI.CreateHorizontalLayoutGroup(newNotesGroup).SetFlexibleWidth(1);

    addButton = UI.CreateButton(buttonContainer)
        .SetText("Add note")
        .SetInteractable(canAddNotes)
        .SetColor("#00FF05")
        .SetFlexibleWidth(1)
        .SetOnClick(addNote);

    selectButton = UI.CreateButton(buttonContainer)
        .SetText("Link")
        .SetInteractable(canAddNotes)
        .SetColor("#0021FF")
        .SetOnClick(addLocation);

    reverseTurnsToggle = UI.CreateButton(buttonContainer)
        .SetText("↑↓")
        .SetColor("#BABABC")
        .SetOnClick(updateNewTurnsTopSetting)
end


function makeNotesList()
    -- update turn number since the turn might have advanced with the window open
    local currentTurn = Mod.PublicGameData.turnNumber or -1;

    -- clear existing notes
    if (not UI.IsDestroyed(existingNotesGroup)) then
        UI.Destroy(existingNotesGroup);
    end

    -- make new notes group
    existingNotesGroup = UI.CreateVerticalLayoutGroup(vert).SetFlexibleWidth(1);

    -- fill main element with existing notes  
    local firstTurn = (newTurnsTop and currentTurn) or 0;
    local lastTurn = (newTurnsTop and 0) or currentTurn;
    local increment = (newTurnsTop and -1) or 1;

    for turn = firstTurn, lastTurn, increment do
        if (notes[turn] ~= nil) then
            UI.CreateLabel(existingNotesGroup).SetText("------   Turn "..turn.."  ------").SetColor("#FF00ED");

            for idx, note in ipairs(notes[turn]) do
                -- create layout group
                noteGroup = UI.CreateHorizontalLayoutGroup(existingNotesGroup).SetFlexibleWidth(1);

                -- add a button for linking to locations
                if (note.location ~= nil) then
                    UI.CreateButton(noteGroup)
                        .SetText(note.location.name)
                        .SetColor("#00F4FF")
                        .SetOnClick(function() highlightTerritories(note.location.ids) end);
                end

                -- add the note text
                local noteWithCRLF = note.noteText:gsub("\\n", "\r\n");
                UI.CreateLabel(noteGroup).SetText(noteWithCRLF).SetFlexibleWidth(1);

                -- add a spacer between notes
                UI.CreateEmpty(existingNotesGroup).SetFlexibleWidth(1).SetPreferredHeight(15);
            end
        end
    end
end


function addNote()
    -- update turn number since the turn might have advanced with the window open
    local currentTurn = Mod.PublicGameData.turnNumber or -1;

    -- get the text the player wrote, and clear its input field
    newNoteText = textField.GetText();
    textField.SetText("");

    if (#newNoteText == 0) then
        -- cannot save empty text
        return;
    end
    
    -- send the note to be saved
    local payload = {noteText = newNoteText, location = selectedLocation}
    sendMessage("Saving note...", payload, sendMessageCallback);

    -- save the new note to local notes list
    if (notes[currentTurn] == nil) then notes[currentTurn] = {}; end
    table.insert(notes[currentTurn], payload);

    -- clear any locations that might have been selected
    removeLocation();

    -- UI update will be done when server message is done sending
end


function sendMessageCallback(replyFromServer)
    -- ignore the reply completely, and just rebuild the exising list of notes
    makeNotesList();
end


function addLocation()
    -- check for new enough client
    if (WL.IsVersionOrHigher == nil or not WL.IsVersionOrHigher("5.17")) then
        UI.Alert("You must update your app to the latest version to use this feature");
        return;
    end

    -- reset location state
    cancelTerritoryClick = false;
    cancelBonusClick = false;
    selectedLocation = nil;

    UI.InterceptNextTerritoryClick(getTerritory)
    UI.InterceptNextBonusLinkClick(getBonus)

    updateLocationContainer(true)
end


function getTerritory(territory)
    if (territory == nil or cancelTerritoryClick) then
        return WL.CancelClickIntercept;
    end

    cancelBonusClick = true;

    selectedLocation = {
        ids = {territory.ID},
        name = territory.Name
    }

    updateLocationContainer(false);
    return WL.CancelClickIntercept;
end


function getBonus(bonus)
    if (bonus == nil or cancelBonusClick) then
        return WL.CancelClickIntercept;
    end

    cancelTerritoryClick = true;

    selectedLocation = {
        ids = bonus.Territories,
        name = bonus.Name
    }

    updateLocationContainer(false);
    return WL.CancelClickIntercept;
end


function removeLocation()
    selectedLocation = nil;
    showInstructions = false;
    updateLocationContainer(false);
end


function updateLocationContainer(showInstructions)
    -- reset the location container
    if (not UI.IsDestroyed(headerLabel)) then
        UI.Destroy(headerLabel);
    end
    
    if (not UI.IsDestroyed(locationLabel)) then
        UI.Destroy(locationLabel);
    end

    if (not UI.IsDestroyed(locatationDeleteBtn)) then
        UI.Destroy(locatationDeleteBtn);
    end

    -- if no location selected, keep them destroyed
    if (selectedLocation == nil and not showInstructions) then
        return;
    end

    -- otherwise, add the location elements
    headerLabel = UI.CreateLabel(locationContainer)
        .SetText("Note will link to: ")
        .SetColor("#BABABC");

    if (showInstructions) then
        locationLabel = UI.CreateLabel(locationContainer)
            .SetText("Select by clicking a a territory/bonus on the map")
            .SetFlexibleWidth(1)
            .SetColor("#FFF700");
    else
        locationLabel = UI.CreateLabel(locationContainer)
            .SetText(selectedLocation.name)
            .SetFlexibleWidth(1)
            .SetColor("#00F4FF");
    end
    
    locatationDeleteBtn = UI.CreateButton(locationContainer)
        .SetText("X")
        .SetColor("#FF0000")
        .SetOnClick(removeLocation);
end


function updateNewTurnsTopSetting()
    newTurnsTop = not newTurnsTop;
    sendMessage("Updating setting...", {changeNewTurnsTopTo = newTurnsTop}, sendMessageCallback);
end