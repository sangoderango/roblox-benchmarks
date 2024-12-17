--!strict
--!optimize 1

local ITERATIONS = 1_000_000

local SEED, MAX = 42, 100

return {
    Title = `Add a random value to a variable {ITERATIONS} times`,
    Trials = 100,
    Prelude = function()
        math.randomseed(SEED)
    end,
    Cleanup = function() end,
    Jobs = {
        ["x += c"] = function()
            local sum = 0

            for _ = 1, ITERATIONS do
                sum += math.random(MAX)
            end
        end,
        ["x = x + c"] = function()
            local sum = 0

            for _ = 1, ITERATIONS do
                sum = sum + math.random(MAX)
            end
        end,
        ["t.x += c"] = function()
            local container = { sum = 0 }

            for _ = 1, ITERATIONS do
                container.sum += math.random(MAX)
            end
        end,
        ["t.x = t.x + c"] = function()
            local container = { sum = 0 }

            for _ = 1, ITERATIONS do
                container.sum = container.sum + math.random(MAX)
            end
        end,
    },
}
