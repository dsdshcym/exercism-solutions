defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    fence = fence(rails)

    str
    |> String.graphemes()
    |> Enum.zip(fence)
    |> Enum.sort_by(fn {_char, fence} -> fence end)
    |> Enum.map(fn {char, _fence} -> char end)
    |> Enum.join()
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    fence = fence(rails)

    1..String.length(str)
    |> Enum.zip(fence)
    |> Enum.sort_by(fn {_index, fence} -> fence end)
    |> Enum.map(fn {index, _fence} -> index end)
    |> Enum.zip(str |> String.graphemes())
    |> Enum.sort()
    |> Enum.map(fn {_index, char} -> char end)
    |> Enum.join()
  end

  defp fence(1), do: [1] |> Stream.cycle()

  defp fence(rails) do
    1..rails
    |> Enum.concat((rails - 1)..2)
    |> Stream.cycle()
  end
end
