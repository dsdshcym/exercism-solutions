defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(binary), do: to_decimal(binary, 0)

  def to_decimal("", result), do: result
  def to_decimal("1" <> rest, result), do: to_decimal(rest, result * 2 + 1)
  def to_decimal("0" <> rest, result), do: to_decimal(rest, result * 2)
  def to_decimal(_bad_input, _result), do: 0
end
