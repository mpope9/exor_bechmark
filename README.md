# ExorBechmark

Benchmarking suite to compare the access performance of the [exor_filter](https://github.com/mpope9/exor_filter)) library against common bloom filter libraries.

The benchmark is simple, it create filters of 1k, 100k, 1M, and 10M elements.  Then it attempts 10k reads from each.

Libraries compared against:
* [Bloomex](https://github.com/gmcabrita/bloomex) - Pure Elixir implementation of Scalable Bloom Filters.
* [Blex](https://github.com/gyson/blex) - Fast Bloom filter powered by erlang atomics.
* [Erbloom](https://github.com/Vonmo/erbloom) - Safe and Fast Bloom Filter that uses a rust nif.

An attempt was made to use [ebloom](https://github.com/basho/ebloom) which also uses a C nif but could not get it to compile.

Warning: these results were ran from a laptop and not a production environment.

## Results
![Benchmark Graph](/images/results.png)

## Benchee Output

```
exor_filter 8 1k Elements           603.77
exor_filter 8 100k Elements         593.32 - 1.02x slower +0.0292 ms
exor_filter 8 1M Elements           570.16 - 1.06x slower +0.0976 ms
exor_filter 8 10M Elements          546.47 - 1.10x slower +0.174 ms
exor_filter 16 100k Elements        325.90 - 1.85x slower +1.41 ms
exor_filter 16 1M Elements          325.64 - 1.85x slower +1.41 ms
exor_filter 16 10M Elements         325.16 - 1.86x slower +1.42 ms
exor_filter 16 1k Elements          318.93 - 1.89x slower +1.48 ms
erbloom 1k Elements                 294.96 - 2.05x slower +1.73 ms
erbloom 10M Elements                294.57 - 2.05x slower +1.74 ms
erbloom 100k Elements               292.23 - 2.07x slower +1.77 ms
erbloom 1M Elements                 290.60 - 2.08x slower +1.78 ms
Bloomex 1k Elements                 230.09 - 2.62x slower +2.69 ms
Blex 1k Elements                    229.09 - 2.64x slower +2.71 ms
Bloomex 100k Elements               100.53 - 6.01x slower +8.29 ms
Blex 100k Elements                   88.10 - 6.85x slower +9.69 ms
Bloomex 1M Elements                  83.31 - 7.25x slower +10.35 ms
Blex 1M Elements                     67.21 - 8.98x slower +13.22 ms
Blex 10M Elements                    65.95 - 9.16x slower +13.51 ms
Bloomex 10M Elements                 47.63 - 12.68x slower +19.34 ms
```

## Instructions
Ensure Rust is installed.

```bash
mix run lib/exor_benchmark.exs
```
