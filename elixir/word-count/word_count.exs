defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence =
      sentence
      |> String.downcase()
      |> String.replace("_", " ", global: true)

    Regex.scan(~r/[\w-]+/u, sentence)
    |> List.flatten()
    |> Enum.reduce(%{}, fn(word, counts) -> Map.update(counts, word, 1, &(&1 + 1)) end)
  end
end
