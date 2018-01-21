defmodule Atbash do
  @plain "abcdefghijklmnopqrstuvwxyz" |> String.graphemes()
  @cipher "zyxwvutsrqponmlkjihgfedcba" |> String.graphemes()
  @digits "1234567890" |> String.graphemes()

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.graphemes()
    |> Enum.map(&encode_char/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.chunk_every(5)
    |> Enum.map(&Enum.join(&1))
    |> Enum.join(" ")
  end

  defp encode_char(digit) when digit in @digits, do: digit

  defp encode_char(char) when char in @plain do
    index =
      @plain
      |> Enum.find_index(&(&1 == char))

    Enum.at(@cipher, index)
  end

  defp encode_char(_), do: ""

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.graphemes()
    |> Enum.reject(&(&1 == " "))
    |> Enum.map(&decode_char/1)
    |> Enum.join()
  end

  defp decode_char(char) when char in @cipher do
    index =
      @cipher
      |> Enum.find_index(&(&1 == char))

    Enum.at(@plain, index)
  end

  defp decode_char(char), do: char
end
