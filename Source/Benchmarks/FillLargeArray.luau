--!strict
--!optimize 1

local ARRAY_SIZE = 1_000_000

local SEED, MAX = 42, 100

return {
    Title = `Fill an array of size {ARRAY_SIZE}`,
    Trials = 100,
    Prelude = function()
        math.randomseed(SEED)
    end,
    Cleanup = function() end,
    Jobs = {
        ["table.insert"] = function()
            local array = {}

            for _ = 1, ARRAY_SIZE do
                table.insert(array, math.random(MAX))
            end
        end,
        ["arr[#k + 1]"] = function()
            local array = {}

            for _ = 1, ARRAY_SIZE do
                array[#array + 1] = math.random(MAX)
            end
        end,
        ["arr[i]"] = function()
            local array = {}

            for index = 1, ARRAY_SIZE do
                array[index] = math.random(MAX)
            end
        end,
        ["table.create table.insert"] = function()
            local array = table.create(ARRAY_SIZE)

            for _ = 1, ARRAY_SIZE do
                table.insert(array, math.random(MAX))
            end
        end,
        ["table.create arr[i]"] = function()
            local array = table.create(ARRAY_SIZE)

            for index = 1, ARRAY_SIZE do
                array[index] = math.random(MAX)
            end
        end,
    },
}
