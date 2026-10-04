Code.require_file("lib/sieve.exs", __DIR__)

# 複数のプロセスを起動する。
pids =
  Enum.map(1..1000, fn _ ->
    spawn(fn ->
      receive do
        # `:primes` を受け取った時、篩の計算を行ない、計算結果をメッセージで送る。
        {:primes, from, n} when is_integer(n) and n >= 0 ->
          primes = Sieve.primes(n)
          # {`:result`, 自身のpid、受け取った整数値、計算結果のList}を送る。
          send(from, {:result, self(), n, primes})
      end
    end)
  end)

# 起動したプロセスにメッセージを送る。
Enum.each(pids, fn pid ->
  n = Enum.random(1..2000)
  # {`:primes`, 自身のpid、整数値}を送る。
  send(pid, {:primes, self(), n})
end)

# 各プロセスの計算結果を受け取る。
results =
  Enum.map(pids, fn pid ->
    receive do
      # {n, primes}を返す。
      {:result, ^pid, n, primes} when is_list(primes) -> {n, primes}
    after
      5000 -> raise "timeout"
    end
  end)

Enum.each(results, fn {n, primes} ->
  IO.puts("#{n}: #{inspect(primes)}")
end)
