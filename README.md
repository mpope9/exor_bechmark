# ExorBechmark

Benchmarking suite to compare the access performance of the [exor_filter](https://github.com/mpope9/exor_filter) library against common bloom filter libraries.

Now featuring the new [efuse_filter](https://github.com/mpope9/efuse_filter), a new serious contender.

The benchmark is simple, it create filters of 1k, 100k, 1M, and 10M elements.  Then it attempts 10k reads from each.

Libraries compared against:
* [Bloomex](https://github.com/gmcabrita/bloomex) - Pure Elixir implementation of Scalable Bloom Filters.
* [Blex](https://github.com/gyson/blex) - Fast Bloom filter powered by erlang atomics.
* [Erbloom](https://github.com/Vonmo/erbloom) - Safe and Fast Bloom Filter that uses a rust nif.
  * To get erbloom to compile, you must modify the `cargo.toml` file to point to the latest `ruslter` version, or it will not compile.

An attempt was made to use [ebloom](https://github.com/basho/ebloom) which also uses a C nif but could not get it to compile.

Warning: these results were ran from a laptop and not a production environment.

## Results
![Benchmark Graph](/images/results.png)

## Benchee Output

```
Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-7267U CPU @ 3.10GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.12.2
Erlang 24.0.5

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 10,000 Inputs
Estimated total run time: 3.50 min

##### With input 10,000 Inputs #####
Name                   ips        average  deviation         median         99th %
fuse8 100           754.37        1.33 ms     ±2.90%        1.32 ms        1.49 ms
fuse8 1k            753.87        1.33 ms     ±2.83%        1.32 ms        1.50 ms
fuse8 100k          750.79        1.33 ms     ±3.48%        1.32 ms        1.57 ms
fuse8 8 1M          705.73        1.42 ms     ±4.58%        1.40 ms        1.71 ms
xor8 1k             691.04        1.45 ms     ±3.73%        1.43 ms        1.69 ms
xor8 100            686.88        1.46 ms    ±12.89%        1.44 ms        1.75 ms
xor8 100k           684.93        1.46 ms     ±3.69%        1.45 ms        1.67 ms
xor16 100           669.36        1.49 ms     ±2.95%        1.49 ms        1.67 ms
xor16 1k            667.76        1.50 ms     ±2.96%        1.49 ms        1.67 ms
xor16 100k          657.30        1.52 ms     ±4.32%        1.51 ms        1.81 ms
fuse8 8 10M         648.42        1.54 ms     ±8.90%        1.51 ms        2.29 ms
xor8 8 1M           645.20        1.55 ms     ±4.88%        1.53 ms        1.94 ms
xor16 1M            624.90        1.60 ms    ±14.33%        1.56 ms        2.26 ms
xor8 8 10M          591.41        1.69 ms    ±10.60%        1.64 ms        2.60 ms
xor16 10M           565.42        1.77 ms     ±8.57%        1.72 ms        2.46 ms
Bloomex 100         373.94        2.67 ms     ±2.61%        2.67 ms        2.96 ms
Bloomex 1k          360.53        2.77 ms     ±2.72%        2.76 ms        3.12 ms
Blex 100            357.88        2.79 ms     ±4.84%        2.78 ms        3.23 ms
Blex 1k             276.03        3.62 ms     ±3.19%        3.61 ms        4.05 ms
erbloom 100         263.52        3.79 ms     ±3.56%        3.77 ms        4.40 ms
erbloom 1k          263.31        3.80 ms     ±2.48%        3.78 ms        4.32 ms
erbloom 10M         256.10        3.90 ms     ±2.86%        3.88 ms        4.51 ms
erbloom 1M          249.09        4.01 ms     ±3.46%        3.98 ms        4.69 ms
erbloom 100k        245.05        4.08 ms    ±15.71%        3.91 ms        7.10 ms
Bloomex 100k        159.57        6.27 ms     ±1.77%        6.24 ms        6.86 ms
Bloomex 1M          112.75        8.87 ms     ±4.31%        8.79 ms       10.59 ms
Blex 100k           102.11        9.79 ms     ±4.25%        9.72 ms       10.84 ms
Blex 1M              75.93       13.17 ms     ±3.38%       13.06 ms       15.17 ms
Bloomex 10M          65.60       15.24 ms     ±7.62%       15.00 ms       16.86 ms
Blex 10M             54.14       18.47 ms     ±1.31%       18.46 ms       19.43 ms

Comparison:
fuse8 100           754.37
fuse8 1k            753.87 - 1.00x slower +0.00089 ms
fuse8 100k          750.79 - 1.00x slower +0.00634 ms
fuse8 8 1M          705.73 - 1.07x slower +0.0914 ms
xor8 1k             691.04 - 1.09x slower +0.122 ms
xor8 100            686.88 - 1.10x slower +0.130 ms
xor8 100k           684.93 - 1.10x slower +0.134 ms
xor16 100           669.36 - 1.13x slower +0.168 ms
xor16 1k            667.76 - 1.13x slower +0.172 ms
xor16 100k          657.30 - 1.15x slower +0.196 ms
fuse8 8 10M         648.42 - 1.16x slower +0.22 ms
xor8 8 1M           645.20 - 1.17x slower +0.22 ms
xor16 1M            624.90 - 1.21x slower +0.27 ms
xor8 8 10M          591.41 - 1.28x slower +0.37 ms
xor16 10M           565.42 - 1.33x slower +0.44 ms
Bloomex 100         373.94 - 2.02x slower +1.35 ms
Bloomex 1k          360.53 - 2.09x slower +1.45 ms
Blex 100            357.88 - 2.11x slower +1.47 ms
Blex 1k             276.03 - 2.73x slower +2.30 ms
erbloom 100         263.52 - 2.86x slower +2.47 ms
erbloom 1k          263.31 - 2.86x slower +2.47 ms
erbloom 10M         256.10 - 2.95x slower +2.58 ms
erbloom 1M          249.09 - 3.03x slower +2.69 ms
erbloom 100k        245.05 - 3.08x slower +2.76 ms
Bloomex 100k        159.57 - 4.73x slower +4.94 ms
Bloomex 1M          112.75 - 6.69x slower +7.54 ms
Blex 100k           102.11 - 7.39x slower +8.47 ms
Blex 1M              75.93 - 9.94x slower +11.84 ms
Bloomex 10M          65.60 - 11.50x slower +13.92 ms
Blex 10M             54.14 - 13.93x slower +17.14 ms
```

## Instructions
Ensure Rust is installed.

```bash
mix run lib/exor_benchmark.exs
```
