function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, clientGame, close, calledFromCode)
    -- make sendMessage function global (we will need it later)
    sendMessage = clientGame.SendGameCustomMessage

    -- create main element
    setMaxSize(500,650);
    vert = UI.CreateVerticalLayoutGroup(rootParent).SetFlexibleWidth(1);
    newNotesGroup = UI.CreateVerticalLayoutGroup(vert).SetFlexibleWidth(1);

    -- get player state
    state = clientGame.Us and clientGame.Us.State or 0 
    canViewNotes = (state >= 2 and state <= 4) or (state >= 7 and state <= 9) -- check is player is or has played in the game
    canAddNotes = (state == WL.GamePlayerState.Playing);

    -- abort if not playing in game
    if (not canViewNotes) then
        UI.CreateLabel(vert).SetText("You can only use notes when playing in this game.")
        return;
    end


    -- load data (and init if needed)
    data = Mod.PlayerGameData;
    if (data == nil) then data = {}; end


    -- construct the existing notes
    makeNotesList()


    -- build the user input elements
    placeholder = (canAddNotes and " Add notes here. Use \\n to insert a new line.") or " Cannot add notes.";

    textField = UI.CreateTextInputField(newNotesGroup)
        .SetPlaceholderText(placeholder)
        .SetInteractable(canAddNotes)
        .SetFlexibleWidth(1)
        .SetPreferredHeight(25);

    addButton = UI.CreateButton(newNotesGroup)
        .SetText("Add note")
        .SetInteractable(canAddNotes)
        .SetColor("#00FF05")
        .SetFlexibleWidth(1)
        .SetOnClick(addNote);
    
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
    for turn = currentTurn, 0, -1 do
        if (data[turn] ~= nil) then
            UI.CreateLabel(existingNotesGroup).SetText("------   Turn "..turn.."  ------").SetColor("#FF00ED");
            for idx, note in ipairs(data[turn]) do
                noteWithCRLF = note:gsub("\\n", "\r\n");
                UI.CreateLabel(existingNotesGroup).SetText(noteWithCRLF).SetFlexibleWidth(1);
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
    sendMessage("Saving note...", {note = newNoteText}, sendMessageCallback);

    -- first, check if its the 1st message this turn
    if (data[currentTurn] == nil)  then
        UI.CreateLabel(existingNotesGroup).SetText("------   Turn "..currentTurn.."  ------").SetColor("#FF00ED");
        data[currentTurn] = {};
    end

    -- then add the note to the screen and save it
    table.insert(data[currentTurn], newNoteText);
end

function sendMessageCallback(replyFromServer)
    -- ignore the reply completely, and just rebuild the exising list of notes
    makeNotesList()
end

