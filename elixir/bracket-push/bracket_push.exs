defmodule BracketPush do
  @bracket_pairs [
    {"[", "]"},
    {"{", "}"},
    {"(", ")"}
  ]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(string) do
    check_brackets(string, [])
  end

  defp check_brackets("", []), do: true
  defp check_brackets("", _unmatched_brackets), do: false

  for {open, close} <- @bracket_pairs do
    defp check_brackets(unquote(open) <> rest, stack) do
      check_brackets(rest, [unquote(open) | stack])
    end
    defp check_brackets(unquote(close) <> rest, [unquote(open) | rest_stack]) do
      check_brackets(rest, rest_stack)
    end
    defp check_brackets(unquote(close) <> _rest, _stack) do
      false
    end
  end

  defp check_brackets(<<_::binary-size(1)>> <> rest, stack) do
    check_brackets(rest, stack)
  end
end
