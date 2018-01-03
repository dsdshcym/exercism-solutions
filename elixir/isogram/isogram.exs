defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> all_valid_letters()
    |> every_letter_only_appeared_once()
  end

  defp all_valid_letters(string) do
    string
    |> String.graphemes()
    |> Enum.filter(&String.match?(&1, ~r/\pL/))
  end

  defp every_letter_only_appeared_once(letters) do
    letters
    |> Enum.group_by(&(&1))
    |> Enum.all?(fn({_char, appears}) -> Enum.count(appears) == 1 end)
  end
end
