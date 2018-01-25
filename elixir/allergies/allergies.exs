defmodule Allergies do
  @allergies ~w[
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  ]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    flags
    |> to_binary_list()
    |> to_allergies_list(@allergies)
  end

  defp to_binary_list(0), do: [0]
  defp to_binary_list(1), do: [1]

  defp to_binary_list(flags) do
    [rem(flags, 2) | to_binary_list(div(flags, 2))]
  end

  defp to_allergies_list([], _allergies), do: []
  defp to_allergies_list(_flags, []), do: []

  defp to_allergies_list([0 | rest_flags], [allergy | rest_allergies]),
    do: to_allergies_list(rest_flags, rest_allergies)

  defp to_allergies_list([1 | rest_flags], [allergy | rest_allergies]),
    do: [allergy | to_allergies_list(rest_flags, rest_allergies)]

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
