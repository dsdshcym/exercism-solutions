defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.map(&clean_text/1)
    |> Enum.flat_map(&count_letter/1)
    |> Enum.reduce(%{}, &merge_results/2)
  end

  defp clean_text(text) do
    text
    |> String.replace(~r/[^\pL]/u, "")
    |> String.downcase()
  end

  defp count_letter(text) do
    text
    |> String.graphemes()
    |> Enum.map(&%{&1 => 1})
  end

  defp merge_results(map1, map2) do
    Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end)
  end
end
