defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, keys) do
    rotate(plaintext, keys, fn {char, key} -> alphabet_rotate(char, key - ?a) end)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, keys) do
    rotate(ciphertext, keys, fn {char, key} -> alphabet_rotate(char, ?a - key) end)
  end

  defp rotate(string, keys, rotate_fn) do
    string
    |> String.to_charlist()
    |> Enum.zip(
      keys
      |> String.to_charlist()
      |> Stream.cycle()
    )
    |> Enum.map(rotate_fn)
    |> to_string()
  end

  defp alphabet_rotate(char, offset) when char in ?a..?z do
    Integer.mod(char - ?a + offset, 26) + ?a
  end

  defp alphabet_rotate(char, _offset), do: char
end
