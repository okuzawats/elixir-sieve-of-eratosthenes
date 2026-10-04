# エラトステネスの篩

Elixirによるエラトステネスの篩の実装。

## 環境構築

[mise](https://mise.jdx.dev/) でElixirとErlangのバージョンを管理する。

```bash
brew install mise
mise install
mise exec -- elixir --version
```

## 実行方法

```bash
mise exec -- elixir main.exs
```

## テストの実行方法

```bash
mise exec -- elixir test/sieve_test.exs
```

## フォーマットの確認

```bash
mise exec -- mix format --check-formatted lib/sieve.exs main.exs test/sieve_test.exs
```
