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

  defp sublist?([], _), do: true
  defp sublist?(a, b) do
    b
    |> Stream.chunk(length(a), 1)
    |> Enum.member?(a)
  end

  defp superlist?(a, b), do: sublist?(b, a)
end
