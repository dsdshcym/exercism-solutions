defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.scan(~r/[\w-]+/u, sentence)
    |> List.flatten()
    |> ignore_underscores()
    |> normalize()
    |> _count()
  end

  defp ignore_underscores(words) do
    words
    |> Enum.flat_map(&String.split(&1, "_"))
  end

  defp normalize(words) do
    words
    |> Enum.map(&String.downcase/1)
  end

  defp _count(words) do
    words
    |> Enum.reduce(%{}, fn word, counts -> Map.update(counts, word, 1, &(&1 + 1)) end)
  end
end
