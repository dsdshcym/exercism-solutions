defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    1..num
    |> Enum.map(&row/1)
  end

  defp row(1), do: [1]

  defp row(num) do
    [
      1
      | row(num - 1) |> Enum.chunk_every(2, 1) |> Enum.map(&Enum.sum/1)
    ]
  end
end
