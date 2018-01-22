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
    rotate(plaintext, keys, fn key -> alphabet_rotate_fn(key - ?a) end)
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
    rotate(ciphertext, keys, fn key -> alphabet_rotate_fn(?a - key) end)
  end

  defp rotate(string, keys, key_to_transform_fn) do
    string
    |> String.to_charlist()
    |> Enum.zip(
      keys
      |> String.to_charlist()
      |> Enum.map(key_to_transform_fn)
      |> Stream.cycle()
    )
    |> Enum.map(fn {char, transform_fn} -> transform_fn.(char) end)
    |> to_string()
  end

  defp alphabet_rotate_fn(offset) do
    fn
      char when char in ?a..?z ->
        Integer.mod(char - ?a + offset, 26) + ?a

      char ->
        char
    end
  end
end
