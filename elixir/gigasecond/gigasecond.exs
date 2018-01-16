defmodule Gigasecond do
  @giga 1_000_000_000

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from(erl_datetime) do
    erl_datetime
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.add(@giga)
    |> NaiveDateTime.to_erl()
  end
end
