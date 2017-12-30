defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    cond do
      empty?(digits) -> nil
      invalid_base?(base_a) -> nil
      invalid_base?(base_b) -> nil
      any_negative?(digits) -> nil
      any_invalid?(digits, base_a) -> nil
      true ->
        digits
        |> to_integer(base_a)
        |> from_integer(base_b)
    end
  end

  defp empty?(digits), do: Enum.empty?(digits)

  defp invalid_base?(base), do: base < 2

  defp any_negative?(digits) do
    digits
    |> Enum.any?(fn(digit) -> digit < 0 end)
  end

  defp any_invalid?(digits, base) do
    digits
    |> Enum.any?(fn(digit) -> digit not in (0..base - 1) end)
  end

  defp to_integer(digits, base) do
    digits
    |> Enum.reduce(fn(digit, result) -> result * base + digit end)
  end

  defp from_integer(number, base), do: _from_integer(number, base) |> Enum.reverse()
  defp _from_integer(number, base) when number < base, do: [number]
  defp _from_integer(number, base) do
    [rem(number, base) | _from_integer(div(number, base), base)]
  end
end
