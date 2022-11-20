function iter(w, h)
    local x, y = 0, 1

    -- return iterator
    return function()
        x = x + 1
        if x > w then y = y + 1; x = 1 end

        if x <= w and y <= h then return x, y end
    end
end