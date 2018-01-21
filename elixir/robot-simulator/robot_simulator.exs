defmodule RobotSimulator do
  defstruct direction: nil, position: nil

  @valid_directions [:north, :south, :east, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    with {:ok, direction} <- validate_direction(direction),
         {:ok, position} <- validate_position(position),
         do: %RobotSimulator{direction: direction, position: position}
  end

  defp validate_direction(direction) when direction in @valid_directions, do: {:ok, direction}
  defp validate_direction(_invalid_direction), do: {:error, "invalid direction"}

  defp validate_position({x, y} = position) when is_integer(x) and is_integer(y),
    do: {:ok, position}

  defp validate_position(_position), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot

  def simulate(robot, "R" <> rest) do
    robot
    |> turn(:right)
    |> simulate(rest)
  end

  def simulate(robot, "L" <> rest) do
    robot
    |> turn(:left)
    |> simulate(rest)
  end

  def simulate(robot, "A" <> rest) do
    robot
    |> advance()
    |> simulate(rest)
  end

  def simulate(_robot, _invalid_instruction), do: {:error, "invalid instruction"}

  defp turn(robot, direction) do
    robot
    |> direction()
    |> update_direction(direction)
    |> create(robot |> position())
  end

  defp update_direction(:north, :right), do: :east
  defp update_direction(:east, :right), do: :south
  defp update_direction(:south, :right), do: :west
  defp update_direction(:west, :right), do: :north
  defp update_direction(:north, :left), do: :west
  defp update_direction(:west, :left), do: :south
  defp update_direction(:south, :left), do: :east
  defp update_direction(:east, :left), do: :north

  defp advance(robot) do
    direction = robot |> direction()
    position = robot |> position()

    new_position =
      position
      |> update_position(direction)

    create(direction, new_position)
  end

  defp update_position({x, y}, :north), do: {x, y + 1}
  defp update_position({x, y}, :east), do: {x + 1, y}
  defp update_position({x, y}, :south), do: {x, y - 1}
  defp update_position({x, y}, :west), do: {x - 1, y}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
