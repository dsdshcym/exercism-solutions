defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    for i <- min_factor..max_factor,
        j <- i..max_factor,
        product = i * j,
        palindrome?(product) do
      {product, [i, j]}
    end
    |> Enum.group_by(fn {product, _} -> product end, fn {_, factors} -> factors end)
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
