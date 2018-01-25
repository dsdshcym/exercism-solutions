defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    palindrome_factors(min_factor, max_factor)
    |> Enum.group_by(fn [i, j] -> i * j end)
  end

  defp palindrome_factors(min_factor, max_factor) do
    for i <- min_factor..max_factor,
        j <- i..max_factor,
        palindrome?(i * j),
        do: [i, j]
  end

  defp palindrome?(number) when is_integer(number) do
    number
    |> Integer.digits()
    |> palindrome?()
  end

  defp palindrome?(list) when is_list(list) do
    list
    |> Enum.reverse()
    |> Kernel.==(list)
  end
end
