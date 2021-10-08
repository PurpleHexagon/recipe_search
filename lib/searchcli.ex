defmodule Searchcli do
  @moduledoc """
  Documentation for `Searchcli`.
  """

  @doc ~S"""
  Entrypoint for the CLI application
  """
  def main(_args \\ []) do
    :ets.new(:recipes, [:named_table])

    IO.puts("Indexing in progress - Please Wait!")
    with {:ok, index} <- Trie.init() do
      IO.puts("Indexing Complete")
      search_term = IO.gets("\nEnter your search term: ") |> String.downcase()
      search = Search.build([index: index])

      result = search.(search_term)
      display_recipe(result)
    else
      :error -> IO.puts("No files where found during indexing")
    end
  end

  # Display the recipes one by one
  defp display_recipe([]) do end
  defp display_recipe([head | tail]) do
    Output.recipe(Map.get(head, :file))

    display_recipe(tail)
  end
end
