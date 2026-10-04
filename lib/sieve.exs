defmodule Sieve do
  @moduledoc """
  エラトステネスの篩
  """

  @doc """
  N以下の素数のリストを昇順で返す。

  Nは0以上の整数とし、負の数や整数以外を渡した場合は `FunctionClauseError` をthrowする。

      iex> Sieve.primes(10)
      [2, 3, 5, 7]

  """
  def primes(number) when is_integer(number) and number >= 0 do
    # 2からnumberまでの整数をkey、trueをそのvalueとするMap。
    # Nが2未満の場合、`2..number` が降順（2, 1, 0…）で生成されてしまうため、ステップを指定する(`//1`)。
    sieve = Map.new(2..number//1, fn n -> {n, true} end)

    # `i * i <= N` を満たす、2以上の整数列（2、3、4、...）。
    nums =
      2
      # 2を初期値として、1ずつ増加する無限数列
      |> Stream.iterate(fn i -> i + 1 end)
      # `i * i <= N` を満たす範囲に数列を制限
      |> Stream.take_while(fn i -> i * i <= number end)

    # numsの各整数に対して、篩を更新する。
    sieve =
      Enum.reduce(nums, sieve, fn i, acc ->
        if acc[i] do
          # 整数iが素数である場合、iの倍数を篩から落とす
          # iの倍数のうちiの自乗未満のものは、より小さい素数で処理済みのため、iの自乗から開始
          # iごとに処理するため、stepをiに設定(`//i`)
          Enum.reduce((i * i)..number//i, acc, fn n, acc2 ->
            Map.put(acc2, n, false)
          end)
        else
          # 整数iが素数でない場合、篩はそのままでOK
          acc
        end
      end)

    # 篩に残った要素（素数）
    # リスト内包表記によって、篩に残ったindexのListを生成して返す。
    for n <- 2..number//1, sieve[n], do: n
  end
end
