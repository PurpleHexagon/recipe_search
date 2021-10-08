defmodule TrieSearch do
  @moduledoc """
  Adapter for search function encapsulating searching via trie data structure.

  This allows for right hand wildcard search to be performed
  """

  @doc ~S"""
  Search the tree for the term
  """
  def search(search_term, tree) do
    String.split(search_term)
    |> search_tree(tree, [])
    |> Enum.take(10)
  end

  # Traverse the tree recursively building up results
  defp search_tree([], _tree, result) do result end
  defp search_tree([search_term | tail], tree, result) do
    new_files = String.graphemes(search_term)
                |> _search_tree(tree, "")
                |> Kernel.get_in([:tree, :files])
    search_tree(tail, tree, combine(result, new_files))
  end

  # Delegated to for recursion of characters of search term to search trie
  defp _search_tree([], tree, _word) do %{:tree => tree} end
  defp _search_tree([search_char | tail], tree, word) do
    cond do
      Map.has_key?(tree, search_char) == true
      -> _search_tree(tail, Map.get(tree, search_char), word <> search_char)
      Map.has_key?(tree, search_char) == false
      -> %{}
    end
  end

  # Combine the results together, favour intersection so that when more search terms match results are ranked higher.
  defp combine(left, right) do
    right_list = MapSet.to_list(if right do right else MapSet.new() end)
    right_left_diff = left -- right_list

    intersection = left -- right_left_diff
    left_intersection_diff = left -- intersection
    right_intersection_diff = right_list -- intersection

    intersection ++ left_intersection_diff ++ sort_files(right_intersection_diff)
  end

  # Sort the files based on if they are a word rather than partial
  defp sort_files(files) do
    if files do
      Enum.sort_by(
        files,
        fn file ->
          {:ok, file} = Map.fetch(file, :is_word)
          file == false
        end
      )
    else
      MapSet.new()
    end
  end
end