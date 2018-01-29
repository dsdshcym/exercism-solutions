defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate(board) do
    board =
      board
      |> Enum.map(&String.graphemes/1)

    for {row, i} <- Enum.with_index(board) do
      for {spot, j} <- Enum.with_index(row) do
        annotate_spot(spot, i, j, board)
      end
    end
    |> Enum.map(&Enum.join/1)
  end

  def annotate_spot("*", _, _, _), do: "*"

  def annotate_spot(spot, row, column, board) do
    board
    |> neighbours_for(row, column)
    |> Enum.filter(&(&1 == "*"))
    |> length()
    |> case do
      0 -> " "
      n when n > 0 -> "#{n}"
    end
  end

  def neighbours_for(board, row, column) do
    for i <- (row - 1)..(row + 1),
        j <- (column - 1)..(column + 1),
        {i, j} != {row, column},
        i >= 0,
        j >= 0,
        i < length(board),
        j < length(List.first(board)),
        do: board |> Enum.at(i) |> Enum.at(j)
  end
end
