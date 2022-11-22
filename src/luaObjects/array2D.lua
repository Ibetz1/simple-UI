function iter(w, h)
    local x, y = 0, 1

    -- return iterator
    return function()
        x = x + 1
        if x > w then y = y + 1; x = 1 end

        if x <= w and y <= h then return x, y end
    end
end

function arr2D(w, h)
    local w, h = w or 1, h or 1
    local arr = {}
    arr.__index = arr
    arr.__call = iter(w, h)

    -- generate array
    for x, y in iter(w, h) do
        arr[x] = {}
        arr[x][y] = {}
    end

    setmetatable(arr, arr)
    return arr
end