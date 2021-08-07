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
Estimated total run time: 2.80 min

##### With input 10,000 Inputs #####
Name                   ips        average  deviation         median         99th %
fuse8 1k            749.31        1.33 ms     ±3.17%        1.33 ms        1.49 ms
fuse8 100k          746.83        1.34 ms     ±2.79%        1.33 ms        1.48 ms
fuse8 8 1M          700.22        1.43 ms     ±4.68%        1.42 ms        1.74 ms
xor8 100k           684.07        1.46 ms     ±3.21%        1.45 ms        1.66 ms
xor8 1k             674.74        1.48 ms     ±3.15%        1.47 ms        1.63 ms
fuse8 8 10M         636.23        1.57 ms    ±13.44%        1.52 ms        2.74 ms
xor8 8 1M           598.47        1.67 ms    ±45.72%        1.54 ms        4.95 ms
xor8 8 10M          591.64        1.69 ms     ±8.51%        1.64 ms        2.44 ms
Bloomex 1k          362.02        2.76 ms     ±2.78%        2.75 ms        3.09 ms
xor16 1M            325.59        3.07 ms     ±2.58%        3.06 ms        3.44 ms
xor16 10M           325.58        3.07 ms     ±2.48%        3.05 ms        3.44 ms
xor16 100k          324.61        3.08 ms     ±3.61%        3.06 ms        3.58 ms
xor16 1k            324.05        3.09 ms     ±8.40%        3.06 ms        3.58 ms
Blex 1k             276.08        3.62 ms     ±3.37%        3.61 ms        4.10 ms
erbloom 1k          255.52        3.91 ms     ±2.24%        3.89 ms        4.37 ms
erbloom 10M         248.20        4.03 ms     ±3.26%        4.00 ms        4.63 ms
erbloom 100k        241.76        4.14 ms    ±18.76%        4.03 ms        6.71 ms
erbloom 1M          240.54        4.16 ms     ±6.22%        4.10 ms        5.60 ms
Bloomex 100k        159.83        6.26 ms     ±1.99%        6.23 ms        6.93 ms
Bloomex 1M          112.84        8.86 ms     ±4.26%        8.77 ms       10.38 ms
Blex 100k           102.44        9.76 ms     ±2.63%        9.71 ms       10.64 ms
Blex 1M              98.90       10.11 ms     ±5.70%        9.96 ms       12.48 ms
Bloomex 10M          66.75       14.98 ms     ±7.37%       14.79 ms       16.56 ms
Blex 10M             54.21       18.45 ms     ±1.42%       18.43 ms       19.71 ms

Comparison:
fuse8 1k            749.31
fuse8 100k          746.83 - 1.00x slower +0.00443 ms
fuse8 8 1M          700.22 - 1.07x slower +0.0936 ms
xor8 100k           684.07 - 1.10x slower +0.127 ms
xor8 1k             674.74 - 1.11x slower +0.147 ms
fuse8 8 10M         636.23 - 1.18x slower +0.24 ms
xor8 8 1M           598.47 - 1.25x slower +0.34 ms
xor8 8 10M          591.64 - 1.27x slower +0.36 ms
Bloomex 1k          362.02 - 2.07x slower +1.43 ms
xor16 1M            325.59 - 2.30x slower +1.74 ms
xor16 10M           325.58 - 2.30x slower +1.74 ms
xor16 100k          324.61 - 2.31x slower +1.75 ms
xor16 1k            324.05 - 2.31x slower +1.75 ms
Blex 1k             276.08 - 2.71x slower +2.29 ms
erbloom 1k          255.52 - 2.93x slower +2.58 ms
erbloom 10M         248.20 - 3.02x slower +2.69 ms
erbloom 100k        241.76 - 3.10x slower +2.80 ms
erbloom 1M          240.54 - 3.12x slower +2.82 ms
Bloomex 100k        159.83 - 4.69x slower +4.92 ms
Bloomex 1M          112.84 - 6.64x slower +7.53 ms
Blex 100k           102.44 - 7.31x slower +8.43 ms
Blex 1M              98.90 - 7.58x slower +8.78 ms
Bloomex 10M          66.75 - 11.22x slower +13.65 ms
Blex 10M             54.21 - 13.82x slower +17.11 ms
```

## Instructions
Ensure Rust is installed.

```bash
mix run lib/exor_benchmark.exs
```
