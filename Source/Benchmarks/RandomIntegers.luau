--!strict
--!optimize 1

local ITERATIONS = 1_000_000

local SEED, MIN, MAX = 42, 10, 100

return {
    Title = `Generate {ITERATIONS} random integers between {MIN} and {MAX}`,
    Trials = 100,
    Prelude = function() end,
    Cleanup = function() end,
    Jobs = {
        ["math.random"] = function()
            math.randomseed(SEED)

            for _ = 1, ITERATIONS do
                local _ = math.random(MIN, MAX)
            end
        end,
        ["Random.NextInteger"] = function()
            local prng = Random.new(SEED)

            for _ = 1, ITERATIONS do
                local _ = prng:NextInteger(MIN, MAX)
            end
        end,
    },
}
