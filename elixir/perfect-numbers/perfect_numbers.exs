defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: pos_integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number), do: {:ok, classify(number, aliquot_sum(number))}

  defp classify(number, aliquot_sum) when aliquot_sum == number, do: :perfect
  defp classify(number, aliquot_sum) when aliquot_sum > number, do: :abundant
  defp classify(number, aliquot_sum) when aliquot_sum < number, do: :deficient

  defp aliquot_sum(number) do
    number
    |> factors_other_than_self()
    |> Enum.sum()
  end

  defp factors_other_than_self(number) do
    number
    |> factors()
    |> Enum.reject(fn x -> x == number end)
  end

  defp factors(number) do
    1..trunc(:math.sqrt(number))
    |> Enum.filter(fn divider -> rem(number, divider) == 0 end)
    |> Enum.flat_map(fn factor -> [factor, div(number, factor)] end)
    |> Enum.uniq()
  end
end
