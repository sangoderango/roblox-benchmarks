--!strict
--!optimize 1

local ARRAY_SIZE = 1_000_000

local SEED = 42
local MAX = 100

local _array: { number }

return {
    Title = `Iterating an array of {ARRAY_SIZE} elements`,
    Trials = 100,
    Prelude = function()
        math.randomseed(SEED)

        _array = table.create(ARRAY_SIZE)

        for _ = 1, ARRAY_SIZE do
            table.insert(_array, math.random(MAX))
        end
    end,
    Jobs = {
        ["i, v in arr"] = function()
            for index, value in _array do
                local _ = index + value
            end
        end,
        ["i, v in ipairs(arr)"] = function()
            for index, value in ipairs(_array) do
                local _ = index + value
            end
        end,
        ["i, v in pairs(arr)"] = function()
            for index, value in pairs(_array) do
                local _ = index + value
            end
        end,
        ["i, v in next, arr"] = function()
            for index, value in next, _array do
                local _ = index + value
            end
        end,
        ["i = 1, #arr"] = function()
            local length = #_array

            for index = 1, length do
                local _ = index + _array[index]
            end
        end,
    },
}
