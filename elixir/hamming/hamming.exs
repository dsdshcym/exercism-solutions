defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(string1, string2) when length(string1) != length(string2) do
    {:error,  "Lists must be the same length"}
  end
  def hamming_distance(string1, string2) do
    count =
      Enum.zip(string1, string2)
      |> Enum.count(fn({a, b}) -> a != b end)

    {:ok, count}
  end
end
