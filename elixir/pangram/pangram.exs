defmodule Pangram do
  @alphabet ?a..?z |> Enum.to_list()

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(""), do: false

  def pangram?(sentence) do
    sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.uniq()
    |> contains_all_alphabet_letters?()
  end

  defp contains_all_alphabet_letters?(charlist) do
    @alphabet
    |> Enum.all?(fn letter -> Enum.member?(charlist, letter) end)
  end
end
