defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance('', ''), do: {:ok, 0}
  def hamming_distance('', _), do: {:error,  "Lists must be the same length"}
  def hamming_distance(_, ''), do: {:error,  "Lists must be the same length"}
  def hamming_distance([char1 | rest1], [char2 | rest2]) do
    case hamming_distance(rest1, rest2) do
      {:ok, rest_distance} ->
        if char1 == char2 do
          {:ok, rest_distance}
        else
          {:ok, 1 + rest_distance}
        end
      {:error, _reason} = error -> error
    end
  end
end
