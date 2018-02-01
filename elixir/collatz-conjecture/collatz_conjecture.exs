defmodule CollatzConjecture do
  require Integer

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(number :: pos_integer) :: pos_integer

  def calc(1), do: 0
  def calc(input) when input > 0 and Integer.is_odd(input), do: 1 + calc(input * 3 + 1)
  def calc(input) when input > 0 and Integer.is_even(input), do: 1 + calc(div(input, 2))
end
