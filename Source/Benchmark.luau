--!strict
--!optimize 2
--!native

local MEDIAN_PERCENTILE = 0.5

local SECOND_TO_MICROSECOND = 1_000_000

type Procedure = () -> ()

type Result = {
    Label: string,
    Time: number,
}

export type Config = {
    Title: string,
    Trials: number,
    Prelude: Procedure,
    Cleanup: Procedure,
    Jobs: { [string]: Procedure },
}

local function Measure(procedure: Procedure): number
    local start_time = os.clock()

    procedure()

    return os.clock() - start_time
end

local function Lerp(start: number, goal: number, alpha: number): number
    assert(alpha >= 0 and alpha <= 1)

    return start + (goal - start) * alpha
end

local function CalculatePercentile(times: { number }, percentile: number): number
    assert(percentile >= 0 and percentile <= 1)

    if #times <= 1 then
        return times[1] or 0
    end

    table.sort(times)

    local rank = percentile * (#times - 1) + 1

    return Lerp(times[math.floor(rank)], times[math.ceil(rank)], rank % 1)
end

local function DisplayResults(title: string, results: { Result })
    table.sort(results, function(first, second)
        return first.Time < second.Time
    end)

    local output = title

    for place, result in next, results do
        local time = math.floor(result.Time * SECOND_TO_MICROSECOND)

        output ..= `\n#{place}: "{result.Label}" took {if time < 1 then "<1" else time} μs!`
    end

    print("\n\n" .. output .. "\n\n")
end

local function Benchmark(config: Config)
    assert(config.Trials >= 1 and config.Trials % 1 == 0, "Trials must be a non-zero positive integer")

    local results, index = {}, 1

    for label, job in next, config.Jobs do
        local times = table.create(config.Trials)

        for iteration = 1, config.Trials do
            config.Prelude()

            times[iteration] = Measure(job)

            config.Cleanup()
        end

        results[index] = {
            Label = label,
            Time = CalculatePercentile(times, MEDIAN_PERCENTILE),
        }

        index += 1

        task.wait()
    end

    DisplayResults(config.Title, results)
end

return Benchmark
