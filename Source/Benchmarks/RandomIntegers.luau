--!strict
--!optimize 1

local ITERATIONS = 10_000

local MIN = 1
local MAX = 100

local SEED = 42

return {
    Title = `Generate {ITERATIONS} random integers between {MIN} and {MAX}`,
    Trials = 100,
    Jobs = {
        ["math.random"] = function()
            math.randomseed(SEED)

            for _ = 1, ITERATIONS do
                local _ = math.random(MIN, MAX)
            end
        end,
        ["Random:NextInteger"] = function()
            local prng = Random.new(SEED)

            for _ = 1, ITERATIONS do
                local _ = prng:NextInteger(MIN, MAX)
            end
        end,
    },
}
