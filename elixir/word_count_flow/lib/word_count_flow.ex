defmodule WordCountFlow do
  @moduledoc """
  Documentation for WordCountFlow.
  """

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    Regex.scan(~r/[\w-]+/u, sentence)
    |> Flow.from_enumerable()
    |> Flow.flat_map(&(&1))
    |> Flow.flat_map(&String.split(&1, "_"))
    |> Flow.map(&String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn() -> %{} end, fn(word, counts) -> Map.update(counts, word, 1, &(&1 + 1)) end)
    |> Enum.into(%{})
  end
end
