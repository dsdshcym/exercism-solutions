defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    letter
    |> build_range()
    |> Enum.map(&line/1)
    |> Enum.map(&pad(&1, size(letter)))
    |> Enum.map(&add_trailing_newline/1)
    |> Enum.join()
  end

  def build_range(?A), do: [?A]

  def build_range(letter) when letter in ?B..?Z do
    Enum.concat(?A..letter, (letter - 1)..?A)
  end

  def line(?A), do: "A"

  def line(letter) do
    to_string([letter]) <>
      String.duplicate(" ", String.length(line(letter - 1))) <> to_string([letter])
  end

  def size(letter), do: letter |> line() |> String.length()

  defp pad(string, count, padding \\ " ") do
    string
    |> String.pad_leading(div(String.length(string) + count, 2), padding)
    |> String.pad_trailing(count, padding)
  end

  defp add_trailing_newline(string) do
    "#{string}\n"
  end
end
