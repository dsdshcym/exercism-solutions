defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    input
    |> String.match?(~r/^\s*$/)
  end

  defp question?(input) do
    input
    |> String.ends_with?("?")
  end

  defp shouting?(input) do
    all_have_cases(input) and all_upcase?(input)
  end

  defp all_have_cases(input) do
    String.downcase(input) != String.upcase(input)
  end

  defp all_upcase?(input) do
    String.upcase(input) == input
  end
end
