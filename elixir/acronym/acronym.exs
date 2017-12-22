defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> split_into_words_by_spaces_and_punctuations()
    |> Enum.flat_map(&take_first_char_and_upper_case_char/1)
    |> Enum.join()
    |> String.upcase()
  end

  defp split_into_words_by_spaces_and_punctuations(string) do
    string
    |> String.split(~r{\W}, trim: true)
  end

  defp take_first_char_and_upper_case_char(word) do
    String.split(word, ~r/(?!^)\p{Ll}/, trim: true)
  end
end
