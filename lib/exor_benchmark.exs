#################################################################################
##
##  Benchmark for exor filter vs popular bloom filters.
##
#################################################################################

defmodule ExorBenchmark.Helpers do
  @moduledoc """
  Helper functions for the benchmark script.
  """

  def generate_bin_list(range) do

      Enum.to_list(range)
      |> Enum.map(
        fn(x) -> 
          x |> Integer.to_string
        end)
  end

  def create_bloomex(bin_list) do

    bf = Bloomex.scalable(length(bin_list), 0.1, 0.1, 2)

    bin_list 
    |> List.foldl(bf, 
      fn x, filter ->
        Bloomex.add(filter, x)
    end)
  end

  def create_blex(bin_list) do

    b = Blex.new(length(bin_list), 0.01)

    bin_list
    |> List.foldl(b,
      fn x, filter ->
        Blex.put(filter, x)
        filter
    end)
  end

  def create_erbloom(bin_list) do

    {:ok, erbloom} = :bloom.new_optimal(length(bin_list), 0.1)

    bin_list
    |> List.foldl(erbloom,
      fn x, filter ->
        :bloom.set(filter, x)
        filter
      end)

  end

  def test_iteration(input, filter, fun) do
    input |> Enum.each(fn x -> fun.(filter, x) end)
  end
end

## Benchmark setup
## This step takes a while.

bin1k   = ExorBenchmark.Helpers.generate_bin_list(1..1_000)
bin10k  = ExorBenchmark.Helpers.generate_bin_list(1..10_000)
bin100k = ExorBenchmark.Helpers.generate_bin_list(1..100_000)
bin1M   = ExorBenchmark.Helpers.generate_bin_list(1..1_000_000)
bin10M  = ExorBenchmark.Helpers.generate_bin_list(1..10_000_000)

xor81k    = :xor8.new(bin1k)
xor8100k  = :xor8.new(bin100k)
xor81M    = :xor8.new(bin1M)
xor810M   = :xor8.new(bin10M)

xor161k    = :xor8.new(bin1k)
xor16100k  = :xor8.new(bin100k)
xor161M    = :xor8.new(bin1M)
xor1610M   = :xor8.new(bin10M)

bloomex1k   = ExorBenchmark.Helpers.create_bloomex(bin1k)
bloomex100k = ExorBenchmark.Helpers.create_bloomex(bin100k)
bloomex1M   = ExorBenchmark.Helpers.create_bloomex(bin1M)
bloomex10M  = ExorBenchmark.Helpers.create_bloomex(bin10M)

blex1k    = ExorBenchmark.Helpers.create_blex(bin1k)
blex100k  = ExorBenchmark.Helpers.create_blex(bin100k)
blex1M    = ExorBenchmark.Helpers.create_blex(bin1M)
blex10M   = ExorBenchmark.Helpers.create_blex(bin10M)

erbloom1k   = ExorBenchmark.Helpers.create_erbloom(bin1k)
erbloom100k = ExorBenchmark.Helpers.create_erbloom(bin100k)
erbloom1M   = ExorBenchmark.Helpers.create_erbloom(bin1M)
erbloom10M  = ExorBenchmark.Helpers.create_erbloom(bin10k)

Benchee.run(
  %{
    "xor8 1k" => 
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor81k, &:xor8.contain/2) end,
    "xor8 100k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor8100k, &:xor8.contain/2) end,
    "xor8 8 1M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor81M, &:xor8.contain/2) end,
    "xor8 8 10M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor810M, &:xor8.contain/2) end,

    "xor16 1k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor161k, &:xor16.contain/2) end,
    "xor16 100k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor16100k, &:xor16.contain/2) end,
    "xor16 1M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor161M, &:xor16.contain/2) end,
    "xor16 10M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, xor1610M, &:xor16.contain/2) end,

    "Bloomex 1k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, bloomex1k, &Bloomex.member?/2) end,
    "Bloomex 100k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, bloomex100k, &Bloomex.member?/2) end,
    "Bloomex 1M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, bloomex1M, &Bloomex.member?/2) end,
    "Bloomex 10M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, bloomex10M, &Bloomex.member?/2) end,

    "Blex 1k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, blex1k, &Blex.member?/2) end,
    "Blex 100k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, blex100k, &Blex.member?/2) end,
    "Blex 1M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, blex1M, &Blex.member?/2) end,
    "Blex 10M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, blex10M, &Blex.member?/2) end,

    "erbloom 1k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, erbloom1k, &:bloom.check/2) end,
    "erbloom 100k" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, erbloom100k, &:bloom.check/2) end,
    "erbloom 1M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, erbloom1M, &:bloom.check/2) end,
    "erbloom 10M" =>
      fn input -> ExorBenchmark.Helpers.test_iteration(input, erbloom10M, &:bloom.check/2) end,
  },
  inputs: %{
    "10,000 Inputs" => bin10k
  },
  formatters: [
    Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)

#pre_hash100   = Enum.to_list(1..100)
#pre_hash1k    = Enum.to_list(1..1_000)
#pre_hash10k   = Enum.to_list(1..10_000)
#pre_hash100k  = Enum.to_list(1..100_000)
#pre_hash1M    = Enum.to_list(1..1_000_000)
#pre_hash10M   = Enum.to_list(1..10_000_000)
#
#xor8_pre1k    = :xor8.new(pre_hash1k, :none)
#xor8_pre100k  = :xor8.new(pre_hash100k, :none)
#xor8_pre1M    = :xor8.new(pre_hash1M, :none)
#xor8_pre10M   = :xor8.new(pre_hash10M, :none)
#
#xor16_pre1k   = :xor16.new(pre_hash1k, :none)
#xor16_pre100k = :xor16.new(pre_hash100k, :none)
#xor16_pre1M   = :xor16.new(pre_hash1M, :none)
#xor16_pre10M  = :xor16.new(pre_hash10M, :none)
#
### pre-hash xor filter benchmark
#Benchee.run(
#  %{
#    "exor_filter 8 pre-hash 1k"   => fn input -> :xor8.contains(xor8_pre1k, input) end,
#    "exor_filter 8 pre-hash 100k" => fn input -> :xor8.contains(xor8_pre100k, input) end,
#    "exor_filter 8 pre-hash 1M"   => fn input -> :xor8.contains(xor8_pre1M, input) end,
#    "exor_filter 8 pre-hash 10M"  => fn input -> :xor8.contains(xor8_pre10M, input) end,
#
#    "exor_filter 16 pre-hash 1k"    => fn input -> :xor8.contains(xor16_pre1k, input) end,
#    "exor_filter 16 pre-hash 100k"  => fn input -> :xor8.contains(xor16_pre100k, input) end,
#    "exor_filter 16 pre-hash 1M"    => fn input -> :xor8.contains(xor16_pre1M, input) end,
#    "exor_filter 16 pre-hash 10M"   => fn input -> :xor8.contains(xor16_pre10M, input) end
#  },
#  inputs: %{
#    "100 Pre-hashed Inputs" => pre_hash100,
#    "1,000 Pre-hashed Inputs" => pre_hash1k,
#    "10,000 Pre-hashed Inputs" => pre_hash10k,
#  },
#  formatters: [
#    Benchee.Formatters.HTML,
#    Benchee.Formatters.Console
#  ]
#)
#
#:xor8.free(xor8_pre1k)
#:xor8.free(xor8_pre100k)
#:xor8.free(xor8_pre1M)
#:xor8.free(xor8_pre10M)
#
#:xor16.free(xor16_pre1k)
#:xor16.free(xor16_pre100k)
#:xor16.free(xor16_pre1M)
#:xor16.free(xor16_pre10M)

## End of simulation.
