defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.trim()
    |> String.downcase()
    |> word_score()
  end

  defp word_score(""), do: 0
  defp word_score(<<char::binary-size(1), rest::binary>>) do
    char_score(char) + word_score(rest)
  end

  defp char_score("a"), do: 1
  defp char_score("e"), do: 1
  defp char_score("i"), do: 1
  defp char_score("o"), do: 1
  defp char_score("u"), do: 1
  defp char_score("l"), do: 1
  defp char_score("n"), do: 1
  defp char_score("r"), do: 1
  defp char_score("s"), do: 1
  defp char_score("t"), do: 1
  defp char_score("d"), do: 2
  defp char_score("g"), do: 2
  defp char_score("b"), do: 3
  defp char_score("c"), do: 3
  defp char_score("m"), do: 3
  defp char_score("p"), do: 3
  defp char_score("f"), do: 4
  defp char_score("h"), do: 4
  defp char_score("v"), do: 4
  defp char_score("w"), do: 4
  defp char_score("y"), do: 4
  defp char_score("k"), do: 5
  defp char_score("j"), do: 8
  defp char_score("x"), do: 8
  defp char_score("q"), do: 10
  defp char_score("z"), do: 10
end
