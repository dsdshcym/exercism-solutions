defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn row_string ->
      row_string |> String.split(" ") |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    with rows <- rows(str),
         length <- length(List.first(rows)) do
      for i <- 0..(length - 1) do
        for row <- rows do
          Enum.at(row, i)
        end
      end
    end
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    columns = columns(str)

    for i <- 0..(length(rows) - 1),
        j <- 0..(length(columns) - 1),
        elem = Enum.at(Enum.at(rows, i), j),
        row = Enum.at(rows, i),
        column = Enum.at(columns, j) do
      if saddle?(elem, row, column) do
        {i, j}
      else
        nil
      end
    end
    |> Enum.reject(&(&1 == nil))
  end

  defp saddle?(elem, row, column) do
    Enum.all?(row, &(&1 <= elem)) and Enum.all?(column, &(&1 >= elem))
  end
end
