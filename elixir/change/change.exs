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
    case bfs([{0, []}], coins, target) do
      :error -> {:error, "cannot change"}
      result -> {:ok, result}
    end
  end

  defp bfs([{target, combination} | _], _coins, target), do: combination |> Enum.sort()
  defp bfs([{current, combination} | rest], coins, target) do
    next = for coin <- coins, coin + current <= target, do: {coin + current, combination ++ [coin]}

    Enum.concat(rest, next)
    |> bfs(coins, target)
  end
  defp bfs([], _, _), do: :error
end
