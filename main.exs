# N
number = 100
# 2からnumberまでの整数をkey、trueをvalueとするMap
# `2..number` は、Nが2未満だと逆向き（2, 1, 0…）になるためstep(`//1`)を指定
sieve = Map.new(2..number//1, fn n -> {n, true} end)
# 篩にかける上限となるindex（Nの平方根まで篩にかければ充分）
max_index = number |> :math.sqrt() |> trunc()

# 第1引数：enumerable、第2引数：初期値、第3引数：indexと最新の篩
# Nが2や3だとmax_indexが1になり、`2..1` は逆向きになるため `//1` を指定
sieve =
  Enum.reduce(2..max_index//1, sieve, fn i, acc ->
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
prime_numbers = for n <- 2..number//1, sieve[n], do: n
prime_numbers |> IO.inspect()
# [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
