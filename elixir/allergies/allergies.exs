defmodule Allergies do
  use Bitwise

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
    for item <- @allergies, allergic_to?(flags, item), do: item
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    index =
      @allergies
      |> Enum.find_index(&(&1 == item))

    (1 <<< index &&& flags) != 0
  end
end
