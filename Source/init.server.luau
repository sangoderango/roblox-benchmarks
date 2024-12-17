--!strict
--!optimize 2
--!native

local Benchmark = require(script.Benchmark)

local Benchmarks = script.Benchmarks
local LargeArrayIteration = require(Benchmarks.LargeArrayIteration)
local FillLargeArray = require(Benchmarks.FillLargeArray)
local RandomIntegers = require(Benchmarks.RandomIntegers)
local RoundingPositives = require(Benchmarks.RoundingPositives)
local SelfAddition = require(Benchmarks.SelfAddition)

task.wait(3)

Benchmark(SelfAddition)
