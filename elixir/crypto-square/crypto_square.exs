defmodule CryptoSquare do
  @doc """
  Encode string rectangle methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    str
    |> normalize()
    |> rectanglize()
    |> transpose()
    |> rectangle_to_string()
  end

  defp normalize(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^[:word:]]/, "")
  end

  defp rectanglize(str) do
    rows =
      str
      |> String.length()
      |> :math.sqrt()
      |> Float.ceil()
      |> trunc()

    str
    |> String.graphemes()
    |> Enum.chunk_every(rows, rows, List.duplicate("", rows))
  end

  defp transpose(rectangle) do
    rectangle
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp rectangle_to_string(rectangle) do
    rectangle
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end
end
