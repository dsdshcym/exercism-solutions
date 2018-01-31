defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""

  def transpose(input) do
    input
    |> String.split("\n")
    |> pad_previous_lines_to_match_later_lines()
    |> Enum.map(&String.graphemes/1)
    |> transpose_lists()
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  defp pad_previous_lines_to_match_later_lines(strings) do
    strings
    |> Enum.reduce([], fn current_line, previous_lines ->
      previous_lines
      |> Enum.map(&String.pad_trailing(&1, String.length(current_line)))
      |> Kernel.++([current_line])
    end)
  end

  defp transpose_lists(lists) do
    # TODO: needs some improvement
    for i <- 0..(length(hd(lists)) - 1) do
      for j <- 0..(length(lists) - 1) do
        get_in(lists, [Access.at(j), Access.at(i)])
      end
    end
  end
end
