defmodule Connect do
  @white_stone "O"
  @black_stone "X"

  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t()]) :: :none | :black | :white
  def result_for(board) do
    board = board |> Enum.map(&String.graphemes/1)

    cond do
      white_wins?(board) -> :white
      black_wins?(board) -> :black
      true -> :none
    end
  end

  defp white_wins?(board) do
    0..(length(hd(board)) - 1)
    |> Enum.any?(&connected_top_down?(board, {0, &1}, @white_stone))
  end

  defp black_wins?(board) do
    board = board |> rotate()

    0..(length(hd(board)) - 1)
    |> Enum.any?(&connected_top_down?(board, {0, &1}, @black_stone))
  end

  defp rotate(board) do
    for i <- 0..(length(hd(board)) - 1) do
      for j <- 0..(length(board) - 1) do
        board
        |> get_in([Access.at(j), Access.at(i)])
      end
    end
  end

  defp connected_top_down?(board) do
  end

  defp connected_top_down?(board, {row, column}, _expected_stone)
       when row >= length(board),
       do: true

  defp connected_top_down?(board, {row, column}, _expected_stone)
       when row < 0
       when column < 0,
       do: false

  defp connected_top_down?(board, {row, column}, expected_stone) do
    board
    |> get_in([Access.at(row), Access.at(column)])
    |> case do
      nil ->
        false

      stone ->
        stone == expected_stone and
          {row, column}
          |> next_steps()
          |> Enum.any?(fn {next_row, next_column} ->
            connected_top_down?(board, {next_row, next_column}, expected_stone)
          end)
    end
  end

  defp next_steps({row, column}) do
    [
      {row + 1, column - 1},
      {row + 1, column},
      {row + 1, column + 1}
    ]
  end
end
