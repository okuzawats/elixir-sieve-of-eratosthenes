Code.require_file("lib/sieve.exs", __DIR__)

# プロセスを起動する。
pid =
  spawn(fn ->
    receive do
      # `:primes` を受け取った時、篩の計算を行ない、計算結果をメッセージで送る。
      {:primes, from, n} when is_integer(n) and n >= 0 ->
        primes = Sieve.primes(n)
        send(from, {:result, primes})
    end
  end)

# 起動したプロセスにメッセージを送る。
send(pid, {:primes, self(), 100})

# mainが `:result` を受け取った時、標準出力する。
receive do
  {:result, primes} ->
    Enum.each(primes, fn n -> IO.puts(n) end)
after
  5000 ->
    IO.puts(:stderr, "timeout")
end
