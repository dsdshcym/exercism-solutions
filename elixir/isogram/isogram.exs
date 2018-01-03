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
    Regex.scan(~r/\pL/, string)
  end

  defp every_letter_only_appeared_once(letters) do
    letters === Enum.uniq(letters)
  end
end
