function notEmpty(table)
    for k, v in pairs(table) do
        return true;
    end
    return false;
end

function tableLength(table) 
    local count = 0;
    for k, v in pairs(table) do
        count = count + 1;
    end
    return count;
end

function PrintProxyInfo(obj)
    print('type=' .. obj.proxyType .. ' readOnly=' .. tostring(obj.readonly) .. ' readableKeys=' .. table.concat(obj.readableKeys, ',') .. ' writableKeys=' .. table.concat(obj.writableKeys, ','));
end

function tprint(tbl, indent)
    if tbl == nil then
        return "tbl is nil";
    end
    if not indent then indent = 0 end

    local toprint = '{\r\n'
    indent = indent + 2

    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(' ', indent)

        if type(k) == 'number' then
            toprint = toprint .. '[' .. k .. '] = ';
        elseif type(k) == 'string' then
            toprint = toprint  .. k ..  ' = ';
        end

        if (type(v) == 'number') then
            toprint = toprint .. v .. ',\r\n';
        elseif (type(v) == "string") then
            toprint = toprint .. '"' .. v .. '",\r\n';
        elseif (type(v) == 'table') then
            local toPrint = v;

            if v.proxyType then
                local proxyTbl = {};

                for _, value in pairs(v.readableKeys) do
                    if value ~= 'readableKeys' then
                        proxyTbl[value] = v[value];
                    end
                end

                toPrint = proxyTbl;
            end

            toprint = toprint .. tprint(toPrint, indent + 2) .. ',\r\n';
        else
            toprint = toprint .. '"' .. tostring(v) .. '",\r\n';
        end
    end

    toprint = toprint .. string.rep(' ', indent-2) .. '}';

    return toprint;
end

function tblprint(tbl)
    print(tprint(tbl));
end


function split(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t,cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
 end
 

 function map(array, func)
     local new_array = {}
     local i = 1;
     for _,v in pairs(array) do
         new_array[i] = func(v);
         i = i + 1;
     end
     return new_array
 end
 
 
 function filter(array, func)
     local new_array = {}
     local i = 1;
     for _,v in pairs(array) do
         if (func(v)) then
             new_array[i] = v;
             i = i + 1;
         end
     end
     return new_array
 end
 

 function first(array, func)
     for _,v in pairs(array) do
         if (func(v)) then
             return v;
         end
     end
     return nil;
 end
 

 function randomFromArray(array)
     local len = #array;
     local i = math.random(len);
     return array[i];
 end
 
 
 function startsWith(str, sub)
     return string.sub(str, 1, string.len(sub)) == sub;
 end