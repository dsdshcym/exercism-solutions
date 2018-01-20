defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit) do
    2..limit
    |> Enum.to_list()
    |> seive(2, limit)
  end

  defp seive(seive, limit, limit), do: seive

  defp seive(seive, current, limit) do
    new_seive =
      seive
      |> Enum.reject(&(&1 != current and rem(&1, current) == 0))

    seive(new_seive, current + 1, limit)
  end
end
