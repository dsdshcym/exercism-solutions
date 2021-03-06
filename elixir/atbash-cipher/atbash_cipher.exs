defmodule Atbash do
  @plain "abcdefghijklmnopqrstuvwxyz" |> String.graphemes()
  @cipher "zyxwvutsrqponmlkjihgfedcba" |> String.graphemes()

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.replace(~r/[^\w]/, "")
    |> String.downcase()
    |> translate(@plain, @cipher)
    |> String.graphemes()
    |> Enum.chunk_every(5)
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(" ", "")
    |> translate(@cipher, @plain)
  end

  defp translate("", _from, _to), do: ""

  defp translate(<<char::binary-size(1)>> <> rest, from, to) do
    translate_char(char, from, to) <> translate(rest, from, to)
  end

  defp translate_char(char, from, to) do
    if char in from do
      index =
        from
        |> Enum.find_index(&(&1 == char))

      Enum.at(to, index)
    else
      char
    end
  end
end
