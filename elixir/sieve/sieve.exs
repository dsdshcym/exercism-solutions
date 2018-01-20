defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit) do
    2..limit
    |> Enum.to_list()
    |> do_seive()
  end

  defp do_seive([]), do: []

  defp do_seive([prime | seive]) do
    new_seive =
      seive
      |> Enum.filter(&(rem(&1, prime) != 0))

    [prime | do_seive(new_seive)]
  end
end
