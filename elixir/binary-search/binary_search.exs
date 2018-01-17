defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search(_numbers, _key, start_index, end_index) when start_index > end_index, do: :not_found
  defp search(numbers, key, start_index, end_index) do
    median_index = div(start_index + end_index, 2)
    median = elem(numbers, median_index)
    cond do
      key == median -> {:ok, median_index}
      key < median -> search(numbers, key, start_index, median_index - 1)
      key > median -> search(numbers, key, median_index + 1, end_index)
    end
  end
end
