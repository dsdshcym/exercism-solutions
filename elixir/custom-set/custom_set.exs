defmodule CustomSet do
  defstruct map: %{}
  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    map =
      for element <- enumerable, into: %{} do
        {element, true}
      end

    %__MODULE__{map: map}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set.map == %{}
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    element in elements(custom_set)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    custom_set_1
    |> elements
    |> Enum.all?(&contains?(custom_set_2, &1))
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1
    |> elements
    |> Enum.all?(&(!contains?(custom_set_2, &1)))
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    elements(custom_set_1) == elements(custom_set_2)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    [element | elements(custom_set)]
    |> new()
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    for element <- elements(custom_set_1), contains?(custom_set_2, element) do
      element
    end
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    for element <- elements(custom_set_1), !contains?(custom_set_2, element) do
      element
    end
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    (elements(custom_set_1) ++ elements(custom_set_2))
    |> new()
  end

  defp elements(custom_set) do
    custom_set.map
    |> Map.keys()
  end
end
