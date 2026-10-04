# lib以下のコードをコンパイルし、警告が1つでもあれば失敗させる
# `elixirc --warnings-as-errors` は警告があっても終了コードが0のため、コンパイラの診断結果で判定する
files = Path.wildcard("lib/**/*.{ex,exs}")

{:ok, _modules, %{compile_warnings: compile_warnings, runtime_warnings: runtime_warnings}} =
  Kernel.ParallelCompiler.compile(files, return_diagnostics: true)

case compile_warnings ++ runtime_warnings do
  [] ->
    IO.puts("No warnings in #{length(files)} file(s)")

  warnings ->
    IO.puts(:stderr, "Found #{length(warnings)} warning(s)")
    System.halt(1)
end
