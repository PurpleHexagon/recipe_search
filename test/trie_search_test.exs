defmodule TrieSearchTest do
  use ExUnit.Case

  test "search trie for pie" do
    {:ok, trie} = Trie.init(["one", "two", "tone", "pie"], "example.txt")
    actual = TrieSearch.search("pie", trie)

    assert actual == [%{file: "example.txt", is_word: true}]
  end

  test "search trie for ton" do
    {:ok, trie} = Trie.init(["one", "two", "tone", "pie"], "example.txt")
    actual = TrieSearch.search("ton", trie)

    assert actual == [%{file: "example.txt", is_word: false}]
  end
end
