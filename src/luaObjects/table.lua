function table.deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[table.deepcopy(orig_key, copies)] = table.deepcopy(orig_value, copies)
            end
            setmetatable(copy, table.deepcopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function table.merge(a, b, temp)
    local temp = temp or {}
    local a, b = a or {}, b or {}

    -- move a to temp
    for key, val in pairs(a) do
        temp[key] = val
    end

    -- merge b with a
    for key, val in pairs(b) do
        -- merge subtables
        if temp[key] then
            if type(temp[key]) == "table" and type(b[key]) == "table" then
                temp[key] = table.merge(temp[key], b[key])
            end
        else

            -- merge table b
            temp[key] = val
        end
    end

    return temp
end