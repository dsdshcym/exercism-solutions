defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      sublist?(a, b) -> :sublist
      superlist?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp equal?(a, b), do: a == b

  defp sublist?([], _b), do: true
  defp sublist?(a = [head | tail_a], [head | tail_b]) do
    sublist_at_start?(tail_a, tail_b) or sublist?(a, tail_b)
  end
  defp sublist?(a, [_unmatch | tail_b]) do
    sublist_at_start?(a, tail_b) or sublist?(a, tail_b)
  end
  defp sublist?(_a, []), do: false

  defp sublist_at_start?([], _b), do: true
  defp sublist_at_start?([head | tail_a], [head | tail_b]), do: sublist_at_start?(tail_a, tail_b)
  defp sublist_at_start?(_a, _b), do: false

  defp superlist?(a, b), do: sublist?(b, a)
end
