defmodule Trie do
  @moduledoc """
  Builds the trie from the recipe files
  """

  @doc ~S"""
  Initialise the trie and return if successful
  """
  def init(words, file) do
    index = build_index_tree(words, %{}, file)

    if index == %{} do
      :error
    else
      {:ok, index}
    end
  end

  def init() do
    index = Path.wildcard("recipes/*.txt") |> index_files(%{})

    if index == %{} do
      :error
    else
      {:ok, index}
    end
  end

  defp index_files([], tree) do tree end
  defp index_files([file | files_tail], tree) do
    {:ok, file_content} = File.read(file)

    # Cache the recipe content for later
    :ets.insert(:recipes, {file, file_content})

    file_content
    |> String.downcase()
    |> String.replace(~r/[^a-z]/, " ")
    |> String.split()
    |> build_index_tree(tree, file)
    |> (&index_files(files_tail, &1)).()
  end

  # Build the tree recursively through words
  defp build_index_tree([], tree, _file) do tree end
  defp build_index_tree([word | words_tail], tree, file) do
    chars = String.graphemes(word)
    build_index_tree(words_tail, build_trie(chars, tree, file), file)
  end

  # Recursively build trie from characters in the word
  defp build_trie([], trie, file) do
    files_from_trie = if Map.get(trie, :files) do
      Map.get(trie, :files)
    else
      MapSet.new()
    end

    trie |> Map.put(:files, MapSet.put(files_from_trie, %{:file => file, :is_word => true}))
  end

  defp build_trie([char | char_tail], trie, file) do
    cond do
      Map.has_key?(trie, char) == true
        -> Map.put(trie, char, build_trie(char_tail, trie[char], file))
           |> fn mutated_trie -> Map.put(mutated_trie, :files, MapSet.put(Map.get(mutated_trie, :files), %{:file => file, :is_word => false})) end.()
      Map.has_key?(trie, char) == false
        -> Map.put(trie, char, build_trie(char_tail, %{}, file))
           |> Map.put(:files, MapSet.new([%{:file => file, :is_word => false}]))
    end
  end
end