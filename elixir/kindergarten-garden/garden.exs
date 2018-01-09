defmodule Garden do
  @default_students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]
  @assignment_length 2

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_students) do
    info_string
    |> to_flower_rows()
    |> group_flowers()
    |> assign_flowers_to_students(Enum.sort(student_names))
  end

  @spec to_flower_rows(String.t()) :: list(list)
  defp to_flower_rows(string) do
    string
    |> String.split("\n")
    |> Enum.map(&row_to_valid_flower_names/1)
  end

  @spec row_to_valid_flower_names(String.t()) :: list
  defp row_to_valid_flower_names(row) do
    row
    |> String.graphemes()
    |> Enum.map(&grapheme_to_flower_name/1)
  end

  @spec grapheme_to_flower_name(String.t()) :: atom
  defp grapheme_to_flower_name("V"), do: :violets
  defp grapheme_to_flower_name("R"), do: :radishes
  defp grapheme_to_flower_name("C"), do: :clover
  defp grapheme_to_flower_name("G"), do: :grass

  defp group_flowers(rows) do
    rows
    |> Enum.map(&Enum.chunk_every(&1, @assignment_length))
    |> Enum.zip()
    |> Enum.map(&(&1 |> Tuple.to_list() |> List.flatten() |> List.to_tuple()))
  end

  defp assign_flowers_to_students(assignments, student_names) do
    default_assignments =
      student_names
      |> Enum.into(%{}, &({&1, {}}))

    [student_names, assignments]
    |> Enum.zip()
    |> Enum.into(default_assignments)
  end
end
