Code.require_file("sieve.ex", __DIR__)

100 |> Sieve.primes() |> Enum.each(fn n -> IO.puts(n) end)
# [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
