defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Stream.flat_map(&multiples_up_to(&1, limit))
    |> Stream.uniq()
    |> Enum.sum()
  end

  defp multiples_up_to(factor, limit) do
    Stream.unfold(
      0,
      fn
        out_of_limit when out_of_limit >= limit -> nil
        multiple when multiple < limit -> {multiple, multiple + factor}
      end
    )
  end
end
