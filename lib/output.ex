defmodule Output do
  @doc ~S"""
  Output the recipe text
  """
  def recipe(filepath) do
    result = case :ets.lookup(:recipes, filepath) do
      [{_filepath, items}] -> items
      [] -> nil
    end

    IO.puts(result <> "\n")
  end
end