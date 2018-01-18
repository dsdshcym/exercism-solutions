defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_digits, size) when size <= 0, do: []

  def slices(digits, size) do
    cond do
      String.length(digits) >= size ->
        substring = String.slice(digits, 0, size)
        rest = digits |> String.slice(1..-1)
        [substring | slices(rest, size)]

      true ->
        []
    end
  end
end
