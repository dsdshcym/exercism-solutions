defmodule PrimeFactors do
  require Integer

  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(2), do: [2]

  def factors_for(number) do
    min_factor =
      2..round(:math.sqrt(number))
      |> Enum.find(number, &(rem(number, &1) == 0))

    [min_factor | factors_for(div(number, min_factor))]
  end
end
