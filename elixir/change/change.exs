defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(_coins, target) when target < 0, do: {:error, "cannot change"}
  def generate(coins, target) do
    case pack(%{0 => []}, 0, coins, target) do
      :error -> {:error, "cannot change"}
      result -> {:ok, result}
    end
  end

  defp pack(combinations, current, _coins, target) when current > target do
    Map.get(combinations, target, :error)
  end
  defp pack(combinations, current, coins, target) do
    coins
    |> Enum.filter(&Map.has_key?(combinations, current - &1))
    |> Enum.min_by(&length(Map.get(combinations, current - &1)), fn -> nil end)
    |> case do
         nil -> pack(combinations, current + 1, coins, target)
         result ->
           current_combination = [result | combinations[current - result]]
           pack(Map.put(combinations, current, current_combination), current + 1, coins, target)
       end
  end
end
