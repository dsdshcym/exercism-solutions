defmodule ISBNVerifier do
  @valid_digits 0..9 |> Enum.map(&to_string/1)

  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(string) do
    isbn_with_dashes?(string) or isbn_without_dashes?(string)
  end

  def isbn_with_dashes?(
        <<part1::binary-size(1), "-", part2::binary-size(3), "-", part3::binary-size(5), "-",
          check::binary-size(1)>>
      ) do
    isbn_without_dashes?(part1 <> part2 <> part3 <> check)
  end

  def isbn_with_dashes?(_), do: false

  def isbn_without_dashes?(<<digits::binary-size(9), check::binary-size(1)>>) do
    valid_digits?(digits) and valid_check?(check) and valid_checksum?(digits, check)
  end

  def isbn_without_dashes?(_), do: false

  defp valid_digits?(digits) do
    digits
    |> String.graphemes()
    |> Enum.all?(&(&1 in @valid_digits))
  end

  defp valid_check?("X"), do: true

  defp valid_check?(check) do
    valid_digits?(check)
  end

  defp valid_checksum?(digits, check) do
    (digits <> check)
    |> String.graphemes()
    |> Enum.map(fn
      "X" -> 10
      digit -> String.to_integer(digit)
    end)
    |> Enum.zip(10..1)
    |> Enum.map(fn {digit, factor} -> digit * factor end)
    |> Enum.reduce(&+/2)
    |> rem(11)
    |> Kernel.==(0)
  end
end
