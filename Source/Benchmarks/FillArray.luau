--!strict
--!optimize 1

local ARRAY_SIZE = 1_000_000

local SEED = 42
local MAX = 10_000

local _array: { number }

return {
    Title = `Fill a dynamic array of size {ARRAY_SIZE}`,
    Trials = 100,
    Prelude = function()
        math.randomseed(SEED)

        _array = {}
    end,
    Jobs = {
        ["table.insert"] = function()
            for iteration = 1, ARRAY_SIZE do
                table.insert(_array, math.random(MAX))
            end
        end,
        ["arr[#arr + 1]"] = function()
            for iteration = 1, ARRAY_SIZE do
                _array[#_array + 1] = math.random(MAX)
            end
        end,
        ["arr[i]"] = function()
            for iteration = 1, ARRAY_SIZE do
                _array[iteration] = math.random(MAX)
            end
        end,
    },
}
