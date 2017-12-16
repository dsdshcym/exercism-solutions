defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(&(rotate_char(&1, shift)))
    |> to_string
  end

  @lower_alphabet ?a..?z |> Enum.to_list
  @upper_alphabet ?A..?Z |> Enum.to_list

  defp rotate_char(char, shift) do
    cond do
      Enum.find_index(@lower_alphabet, &(&1 == char)) ->
        String.at(to_string(@lower_alphabet), rem(Enum.find_index(@lower_alphabet, &(&1 == char)) + shift, 26))
      Enum.find_index(@upper_alphabet, &(&1 == char)) ->
        String.at(to_string(@upper_alphabet), rem(Enum.find_index(@upper_alphabet, &(&1 == char)) + shift, 26))
      true ->
        char
    end
  end
end
