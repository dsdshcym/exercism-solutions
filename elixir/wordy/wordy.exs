defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    question
    |> remove_trailing_question_mark()
    |> split_into_list()
    |> parse_words_list()
    |> calc()
  end

  defp remove_trailing_question_mark(sentence) do
    sentence
    |> String.replace(~r/\??$/, "")
  end

  defp split_into_list(sentence) do
    sentence
    |> String.split(" ")
  end

  defp parse_words_list(["What", "is" | rest]) do
    parse_words_list(rest)
  end

  defp parse_words_list(["plus" | rest]) do
    [:+ | parse_words_list(rest)]
  end

  defp parse_words_list(["minus" | rest]) do
    [:- | parse_words_list(rest)]
  end

  defp parse_words_list(["multiplied", "by" | rest]) do
    [:* | parse_words_list(rest)]
  end

  defp parse_words_list(["divided", "by" | rest]) do
    [:div | parse_words_list(rest)]
  end

  defp parse_words_list([number_string | rest]) do
    [String.to_integer(number_string) | parse_words_list(rest)]
  end

  defp parse_words_list([]), do: []

  defp calc([a, :+, b | rest]) do
    calc([a + b | rest])
  end

  defp calc([a, :-, b | rest]) do
    calc([a - b | rest])
  end

  defp calc([a, :*, b | rest]) do
    calc([a * b | rest])
  end

  defp calc([a, :div, b | rest]) do
    calc([div(a, b) | rest])
  end

  defp calc([result]), do: result
end
