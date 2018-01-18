defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()

  def convert(number) do
    ""
    |> maybe_concat(rem(number, 3) == 0, "Pling")
    |> maybe_concat(rem(number, 5) == 0, "Plang")
    |> maybe_concat(rem(number, 7) == 0, "Plong")
    |> fallback_if_empty(to_string(number))
  end

  defp maybe_concat(result, true, sound) do
    result <> sound
  end

  defp maybe_concat(result, false, _sound) do
    result
  end

  defp fallback_if_empty("", sound) do
    sound
  end

  defp fallback_if_empty(result, _sound) do
    result
  end
end
