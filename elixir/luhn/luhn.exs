defmodule Luhn do

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    valid_format?(number) and valid_luhn?(convert_string_to_integer_list(number))
  end

  defp valid_format?(number) do
    cond do
      single_char?(number) -> false
      include_non_digits_and_spaces?(number) -> false
      include_leading_spaces?(number) -> false
      true -> true
    end
  end

  defp single_char?(number), do: 1 == String.length(number)

  defp include_non_digits_and_spaces?(number), do: number |> String.match?(~r/[^\d\s]/)

  defp include_leading_spaces?(number), do: number |> String.match?(~r/^\s+/)

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
      head |
      digits_start_from_second |> Enum.map_every(2, &transform_digit/1)
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
