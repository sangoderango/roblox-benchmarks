--!strict
--!optimize 2

local DEFAULT_TRIALS = 10

local SECOND_TO_MICROSECOND = 1_000_000

type Procedure = () -> ()

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

local function Benchmark(config: Config)
    local trials = config.Trials or DEFAULT_TRIALS

    assert(trials > 0 and trials % 1 == 0, "Trials must be a non-zero positive integer")

    local output = config.Title

    for label, job in next, config.Jobs do
        local times = table.create(trials)

        for trial = 1, trials do
            TryCall(config.Prelude)

            local start_time = os.clock()

            job()

            times[trial] = os.clock() - start_time
        end

        table.sort(times)

        local median = times[trials // 2] * SECOND_TO_MICROSECOND

        output ..= `\n"{label}" took {if median < 1 then "<1" else median // 1} μs!`

        task.wait()
    end

    print("\n\n" .. output .. "\n\n")
end

return Benchmark
