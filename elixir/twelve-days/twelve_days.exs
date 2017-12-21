defmodule TwelveDays do
  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{to_order(number)} day of Christmas my true love gave to me, #{gifts_sentence(number..1)}."
  end

  defp to_order(1), do: "first"
  defp to_order(2), do: "second"
  defp to_order(3), do: "third"
  defp to_order(4), do: "fourth"
  defp to_order(5), do: "fifth"
  defp to_order(6), do: "sixth"
  defp to_order(7), do: "seventh"
  defp to_order(8), do: "eighth"
  defp to_order(9), do: "ninth"
  defp to_order(10), do: "tenth"
  defp to_order(11), do: "eleventh"
  defp to_order(12), do: "twelfth"

  defp gifts_sentence(days) do
    days
    |> gifts()
    |> to_sentence()
  end

  defp gifts(days) do
    days
    |> Enum.map(&days_to_gift/1)
  end

  defp days_to_gift(1), do: "a Partridge in a Pear Tree"
  defp days_to_gift(2), do: "two Turtle Doves"
  defp days_to_gift(3), do: "three French Hens"
  defp days_to_gift(4), do: "four Calling Birds"
  defp days_to_gift(5), do: "five Gold Rings"
  defp days_to_gift(6), do: "six Geese-a-Laying"
  defp days_to_gift(7), do: "seven Swans-a-Swimming"
  defp days_to_gift(8), do: "eight Maids-a-Milking"
  defp days_to_gift(9), do: "nine Ladies Dancing"
  defp days_to_gift(10), do: "ten Lords-a-Leaping"
  defp days_to_gift(11), do: "eleven Pipers Piping"
  defp days_to_gift(12), do: "twelve Drummers Drumming"

  defp to_sentence([]), do: ""
  defp to_sentence([only_part]), do: "#{only_part}"
  defp to_sentence([previous, last]), do: "#{previous}, and #{last}"
  defp to_sentence([head | tail]), do: "#{head}, #{to_sentence(tail)}"
end
