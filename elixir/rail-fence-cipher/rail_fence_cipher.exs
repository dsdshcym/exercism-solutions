defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    str
    |> transpose(encode_rule(str, rails))
  end

  defp encode_rule(str, rails) do
    rails
    |> fence()
    |> Enum.take(String.length(str))
    |> Enum.with_index()
    |> Enum.group_by(fn {fence, _index} -> fence end, fn {_fence, index} -> index end)
    |> Enum.flat_map(fn {_fence, indices} -> indices end)
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    str
    |> transpose(decode_rule(str, rails))
  end

  defp decode_rule(str, rails) do
    encode_rule(str, rails)
    |> revert()
  end

  defp fence(1), do: [1] |> Stream.cycle()

  defp fence(rails) do
    1..rails
    |> Enum.concat((rails - 1)..2)
    |> Stream.cycle()
  end

  defp transpose(str, rule) do
    rule
    |> Enum.map(&String.at(str, &1))
    |> Enum.join()
  end

  defp revert(rule) do
    rule
    |> Enum.with_index()
    |> Enum.sort()
    |> Enum.map(fn {index, position} -> position end)
  end
end
