defmodule Queens do
  @type chess :: {integer, integer}
  @type t :: %Queens{ black: chess, white: chess }
  defstruct black: nil, white: nil

  @blank_board """
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  """ |> String.trim() |> String.split("\n") |> Enum.map(&String.split/1)

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(), do: new({0, 3}, {7, 3})
  def new(same, same), do: raise ArgumentError
  def new(white, black) do
    %Queens{black: black, white: white}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    @blank_board
    |> place('W', queens.white)
    |> place('B', queens.black)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  defp place(board, chess, {x, y}) do
    board
    |> List.update_at(x, &(List.replace_at(&1, y, chess)))
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {row, _}, white: {row, _}}), do: true
  def can_attack?(%Queens{black: {_, column}, white: {_, column}}), do: true
  def can_attack?(%Queens{black: {row_b, column_b}, white: {row_w, column_w}}) when abs(row_b - row_w) == abs(column_b - column_w), do: true
  def can_attack?(_queens), do: false
end
