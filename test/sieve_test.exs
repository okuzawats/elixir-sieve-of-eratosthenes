Code.require_file("../lib/sieve.exs", __DIR__)

ExUnit.start()

defmodule SieveTest do
  use ExUnit.Case, async: true

  describe "primes/1" do
    test "Nが負の整数の場合はエラーとする" do
      assert_raise FunctionClauseError, fn -> Sieve.primes(-1) end
    end

    test "Nが整数以外の場合はエラーとする" do
      assert_raise FunctionClauseError, fn -> Sieve.primes(1.0) end
      assert_raise FunctionClauseError, fn -> Sieve.primes("1") end
    end

    test "Nが0の場合は空リストを返す" do
      assert Sieve.primes(0) == []
    end

    test "Nが1の場合は空リストを返す" do
      assert Sieve.primes(1) == []
    end

    test "Nが2の場合は2のみを返す" do
      assert Sieve.primes(2) == [2]
    end

    test "Nが3の場合は2と3を返す" do
      assert Sieve.primes(3) == [2, 3]
    end

    test "Nが4の場合は2と3を返す" do
      assert Sieve.primes(4) == [2, 3]
    end

    test "Nが素数の場合はNも返す" do
      assert Sieve.primes(5) == [2, 3, 5]
    end

    test "Nが100の場合は100以下の素数をすべて返す" do
      assert Sieve.primes(100) == [
               2,
               3,
               5,
               7,
               11,
               13,
               17,
               19,
               23,
               29,
               31,
               37,
               41,
               43,
               47,
               53,
               59,
               61,
               67,
               71,
               73,
               79,
               83,
               89,
               97
             ]
    end

    test "Nが大きい整数の場合でも正しい数の素数を返す" do
      # 10000以下の素数は1229個
      assert length(Sieve.primes(10_000)) == 1229
    end
  end
end
