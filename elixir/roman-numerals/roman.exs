defmodule Roman do
  @mapping [
    [1000, "M"],
    [900, "CM"],
    [500, "D"],
    [400, "CD"],
    [100, "C"],
    [90, "XC"],
    [50, "L"],
    [40, "XL"],
    [10, "X"],
    [9, "IX"],
    [5, "V"],
    [4, "IV"],
    [1, "I"]
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    @mapping
    |> Enum.reduce({number, ""}, &test/2)
    |> elem(1)
  end

  defp test([limit, roman], {number, result}) when number >= limit do
    test([limit, roman], {number - limit, result <> roman})
  end

  defp test(_, {number, result}), do: {number, result}
end
