defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(nil), do: []
  def flatten(item) when not is_list(item), do: [item]
  def flatten(list) when is_list(list) do
    list
    |> Enum.map(&flatten/1)
    |> Enum.reduce([], &(&2 ++ &1))
  end
end
