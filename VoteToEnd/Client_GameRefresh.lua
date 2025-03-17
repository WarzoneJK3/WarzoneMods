require("Annotations");

function Client_GameRefresh(game)
    if (game.Us == nil) then return; end -- dont show popups for spectators, since PlayerGameData isnt available for them, so popup cant be disabled

    local data = Mod.PlayerGameData or {};
    
    if (data.showWarning == nil) then data.showWarning = false; end
    if (data.warningMessage == nil) then data.warningMessage = ""; end
    
    if (data.showWarning) then
        UI.Alert(data.warningMessage);
        game.SendGameCustomMessage("Updating server, please wait... ", {msg = "WarningSeen"}, function(reply) end);
    end

    -- For the sake of debugging, print public game data to mod console
    print(tableToString(Mod.PublicGameData));
end


function tableToString(tbl, indent)
    if (tbl == nil) then
        return "tbl is nil";
    end

    if (not indent) then indent = 0 end

    local toprint = "{\r\n"
    indent = indent + 2

    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)

        if type(k) == "number" then
            toprint = toprint .. "[" .. k .. "] = ";
        elseif type(k) == "string" then
            toprint = toprint  .. k ..  " = ";
        end

        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n";
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n";
        elseif (type(v) == "table") then
            local toPrint = v;

            if v.proxyType then
                local proxyTbl = {};

                for _, value in pairs(v.readableKeys) do
                    if value ~= "readableKeys" then
                        proxyTbl[value] = v[value];
                    end
                end

                toPrint = proxyTbl;
            end

            toprint = toprint .. tableToString(toPrint, indent + 2) .. ",\r\n";
        else
            toprint = toprint .. tostring(v) .. ",\r\n";
        end
    end

    toprint = toprint .. string.rep(" ", indent-2) .. "}";
    return toprint;
end