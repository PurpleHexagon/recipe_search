defmodule Search do
  @default_bridge TrieSearch
  @doc ~S"""
  Build the search function based on options and return the func with the correct bridge and index
  """
  def build(opts \\ []) do
    {bridge, _opts} = Keyword.pop(opts, :bridge, @default_bridge)
    {index, _opts} = Keyword.pop(opts, :index)
    fn search_term -> bridge.search(search_term, index) end
  end
end
