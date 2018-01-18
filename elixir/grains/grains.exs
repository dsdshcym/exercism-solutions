defmodule Grains do
  import Bitwise, only: [<<<: 2]

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when 1 <= number and number <= 64, do: {:ok, _square(number)}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  defp _square(number), do: 1 <<< (number - 1)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, _total()}
  end

  defp _total do
    1..64
    |> Enum.map(&_square/1)
    |> Enum.sum()
  end
end
