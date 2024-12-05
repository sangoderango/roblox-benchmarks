--!strict
--!optimize 2

local DEFAULT_TRIALS = 10

local SECOND_TO_MICROSECOND = 1_000_000

type Procedure = () -> ()

type Result = {
    Label: string,
    Time: number,
}

export type Config = {
    Title: string,
    Trials: number?,
    Prelude: Procedure?,
    Jobs: { [string]: Procedure },
}

local function TryCall(procedure: Procedure?)
    if procedure then
        procedure()
    end
end

local function Measure(procedure: Procedure)
    local start_time = os.clock()

    procedure()

    return os.clock() - start_time
end

local function DisplayResults(title: string, results: { Result })
    table.sort(results, function(first, second)
        return first.Time < second.Time
    end)

    local output = title

    for place, result in next, results do
        output ..= `\n#{place}: "{result.Label}" took {if result.Time < 1 then "<1" else result.Time // 1} μs!`
    end

    print("\n\n" .. output .. "\n\n")
end

local function Benchmark(config: Config)
    local trials = config.Trials or DEFAULT_TRIALS

    assert(trials > 0 and trials % 1 == 0, "Trials must be a non-zero positive integer")

    local results: { Result } = {}

    for label, job in next, config.Jobs do
        local times = table.create(trials)

        for trial = 1, trials do
            TryCall(config.Prelude)

            times[trial] = Measure(job)
        end

        table.sort(times)

        local median_time = times[trials // 2] * SECOND_TO_MICROSECOND

        table.insert(results, { Label = label, Time = median_time })

        task.wait()
    end

    DisplayResults(config.Title, results)
end

return Benchmark
