defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    with true <- longer_than_1_chars?(number),
         true <- only_digits_and_spaces?(number),
         true <- no_leading_spaces?(number),
         digits <- convert_string_to_integer_list(number),
         do: valid_luhn?(digits)
  end

  defp longer_than_1_chars?(number), do: String.length(number) > 1

  defp only_digits_and_spaces?(number), do: not (number |> String.match?(~r/[^\d\s]/))

  defp no_leading_spaces?(number), do: not (number |> String.match?(~r/^\s+/))

  defp convert_string_to_integer_list(string) do
    string
    |> String.replace(~r/[^\d]/, "")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp valid_luhn?(digits) do
    digits
    |> Enum.reverse()
    |> transform_every_second_digits()
    |> Enum.sum()
    |> divisable_by_10?()
  end

  defp transform_every_second_digits([head | digits_start_from_second]) do
    [
      head
      | digits_start_from_second |> Enum.map_every(2, &transform_digit/1)
    ]
  end

  defp transform_digit(digit) when digit * 2 > 9 do
    digit * 2 - 9
  end

  defp transform_digit(digit) do
    digit * 2
  end

  defp divisable_by_10?(number) when rem(number, 10) == 0, do: true
  defp divisable_by_10?(_number), do: false
end
