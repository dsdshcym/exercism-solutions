defmodule Hexadecimal do
  @valid_digits ~w(0 1 2 3 4 5 6 7 8 9 a b c d e f A B C D E F)

  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    to_decimal(hex, 0)
  end

  defp to_decimal("", result), do: result
  defp to_decimal(<<digit::binary-size(1)>> <> _, _result) when digit not in @valid_digits, do: 0
  defp to_decimal(<<digit::binary-size(1)>> <> rest, result) do
    to_decimal(rest, result * 16 + hex_digit_to_dec(digit))
  end

  defp hex_digit_to_dec("0"), do: 0
  defp hex_digit_to_dec("1"), do: 1
  defp hex_digit_to_dec("2"), do: 2
  defp hex_digit_to_dec("3"), do: 3
  defp hex_digit_to_dec("4"), do: 4
  defp hex_digit_to_dec("5"), do: 5
  defp hex_digit_to_dec("6"), do: 6
  defp hex_digit_to_dec("7"), do: 7
  defp hex_digit_to_dec("8"), do: 8
  defp hex_digit_to_dec("9"), do: 9
  defp hex_digit_to_dec("a"), do: 10
  defp hex_digit_to_dec("b"), do: 11
  defp hex_digit_to_dec("c"), do: 12
  defp hex_digit_to_dec("d"), do: 13
  defp hex_digit_to_dec("e"), do: 14
  defp hex_digit_to_dec("f"), do: 15
  defp hex_digit_to_dec("A"), do: 10
  defp hex_digit_to_dec("B"), do: 11
  defp hex_digit_to_dec("C"), do: 12
  defp hex_digit_to_dec("D"), do: 13
  defp hex_digit_to_dec("E"), do: 14
  defp hex_digit_to_dec("F"), do: 15
end
