defmodule TrieTest do
  use ExUnit.Case

  test "init trie returns correct trie" do
    {:ok, trie} = Trie.init(["one", "two", "tone", "pie", "piece"], "example.txt")
    expected = %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "o" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "n" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "e" => %{files: MapSet.new([%{file: "example.txt", is_word: true}])}}}, "p" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "i" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "e" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "c" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "e" => %{files: MapSet.new([%{file: "example.txt", is_word: true}])}}}}}, "t" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "o" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "n" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "e" => %{files: MapSet.new([%{file: "example.txt", is_word: true}])}}}, "w" => %{:files => MapSet.new([%{file: "example.txt", is_word: false}]), "o" => %{files: MapSet.new([%{file: "example.txt", is_word: true}])}}}}

    assert expected == trie
  end

  test "trie sets is_word true and file correctly" do
    {:ok, trie} = Trie.init(["one", "two", "tone", "pie", "piece"], "example.txt")

    assert MapSet.new([%{file: "example.txt", is_word: true}]) == Kernel.get_in(trie, ["o", "n", "e", :files])
  end

  test "trie sets is_word false and file correctly" do
    {:ok, trie} = Trie.init(["one", "two", "tone", "pie", "piece"], "example.txt")

    assert MapSet.new([%{file: "example.txt", is_word: false}]) == Kernel.get_in(trie, ["o", "n", :files])
  end
end
