--!strict
--!optimize 2

local Benchmark = require(script.Benchmark)

local ArrayIteration = require(script.Benchmarks.ArrayIteration)
local RandomIntegers = require(script.Benchmarks.RandomIntegers)
local FillArray = require(script.Benchmarks.FillArray)

task.wait(3)

Benchmark(ArrayIteration)
