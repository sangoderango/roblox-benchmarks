--!strict
--!optimize 1
--!native

local ITERATIONS = 1_000_000

local SEED, MAX = 42, 100

return {
    Title = `Round {ITERATIONS} random positive numbers`,
    Trials = 100,
    Prelude = function()
        math.randomseed(SEED)
    end,
    Cleanup = function() end,
    Jobs = {
        ["math.round"] = function()
            for _ = 1, ITERATIONS do
                local value = math.random() * MAX

                local _ = math.round(value)
            end
        end,
        ["(x + 0.5) // 1"] = function()
            for _ = 1, ITERATIONS do
                local value = math.random() * MAX

                local _ = (value + 0.5) // 1
            end
        end,
        ["math.floor"] = function()
            for _ = 1, ITERATIONS do
                local value = math.random() * MAX

                local _ = math.floor(value)
            end
        end,
        ["x // 1"] = function()
            for _ = 1, ITERATIONS do
                local value = math.random() * MAX

                local _ = value // 1
            end
        end,
        ["math.ceil"] = function()
            for _ = 1, ITERATIONS do
                local value = math.random() * MAX

                local _ = math.ceil(value)
            end
        end,
        ["(x + 1) // 1"] = function()
            for _ = 1, ITERATIONS do
                local value = math.random() * MAX

                local _ = (value + 1) // 1
            end
        end,
    },
}
