defmodule FactorRule do
  defstruct [:factor, :sound]

  def to_sound(%FactorRule{factor: factor, sound: sound}, number) when rem(number, factor) == 0 do
    sound
  end

  def to_sound(_, _) do
    ""
  end
end

defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t

  @rules [
      %FactorRule{factor: 3, sound: "Pling"},
      %FactorRule{factor: 5, sound: "Plang"},
      %FactorRule{factor: 7, sound: "Plong"}
    ]

  def convert(number) do
    @rules
    |> Enum.map(&(FactorRule.to_sound(&1, number)))
    |> Enum.join
    |> or_number_string(number)
  end

  def or_number_string("", number) do
    to_string(number)
  end

  def or_number_string(result, number) do
    result
  end
end
