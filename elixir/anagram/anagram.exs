defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(&1, base))
  end

  defp anagram?(target, base) do
    if String.downcase(target) === String.downcase(base) do
      false
    else
      sorted_grapheme(target) == sorted_grapheme(base)
    end
  end

  defp sorted_grapheme(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
