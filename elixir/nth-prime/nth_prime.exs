defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: primes_stream() |> Enum.at(count - 1)

  defp primes_stream do
    2
    |> Stream.unfold(fn
      2 -> {2, 3}
      odd -> {odd, odd + 2}
    end)
    |> Stream.filter(&is_prime?/1)
  end

  defp is_prime?(2), do: true
  defp is_prime?(3), do: true

  defp is_prime?(n) do
    2..trunc(:math.sqrt(n))
    |> Enum.all?(&(rem(n, &1) != 0))
  end
end
