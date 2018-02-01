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
    with {:ok, digits} <- digits_to_integer(digits |> String.graphemes()),
         {:ok, check} <- check_to_integer(check) do
      digits
      |> Enum.zip(10..2)
      |> Enum.map(fn {digit, factor} -> digit * factor end)
      |> Enum.reduce(&+/2)
      |> Kernel.+(check)
      |> rem(11)
      |> Kernel.==(0)
    end
  end

  def isbn_without_dashes?(_), do: false

  defp digits_to_integer(digits) do
    if digits |> Enum.all?(&(&1 in @valid_digits)) do
      {:ok, digits |> Enum.map(&String.to_integer/1)}
    else
      false
    end
  end

  defp check_to_integer("X"), do: {:ok, 10}
  defp check_to_integer(check) when check in @valid_digits, do: {:ok, String.to_integer(check)}
  defp check_to_integer(_), do: false
end
