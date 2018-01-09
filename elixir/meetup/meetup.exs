defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, :first), do: next_weekday(year, month, 1, weekday_to_integer(weekday))
  def meetup(year, month, weekday, :second), do: next_weekday(year, month, 8, weekday_to_integer(weekday))
  def meetup(year, month, weekday, :third), do: next_weekday(year, month, 15, weekday_to_integer(weekday))
  def meetup(year, month, weekday, :fourth), do: next_weekday(year, month, 22, weekday_to_integer(weekday))
  def meetup(year, month, weekday, :teenth), do: next_weekday(year, month, 13, weekday_to_integer(weekday))
  def meetup(year, month, weekday, :last), do: previous_weekday(year, month, 31, weekday_to_integer(weekday))
  
  defp weekday_to_integer(:monday), do: 1
  defp weekday_to_integer(:tuesday), do: 2
  defp weekday_to_integer(:wednesday), do: 3
  defp weekday_to_integer(:thursday), do: 4
  defp weekday_to_integer(:friday), do: 5
  defp weekday_to_integer(:saturday), do: 6
  defp weekday_to_integer(:sunday), do: 7
  
  defp next_weekday(year, month, day, weekday) do
    {:ok, date} = Date.new(year, month, day)
    next_weekday(date, weekday)
  end
  defp next_weekday(date, weekday) do
    if Date.day_of_week(date) == weekday do
      Date.to_erl(date)
    else
      date
      |> Date.add(1)
      |> next_weekday(weekday)
    end
  end
  
  defp previous_weekday(year, month, day, weekday) do
    case Date.new(year, month, day) do
      {:ok, date} -> previous_weekday(date, weekday)
      {:error, _} -> previous_weekday(year, month, day - 1, weekday)
    end
  end
  defp previous_weekday(date, weekday) do
    if Date.day_of_week(date) == weekday do
      Date.to_erl(date)
    else
      date
      |> Date.add(-1)
      |> previous_weekday(weekday)
    end
  end
end
