defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(string) do
    check_brackets(string, [])
  end

  defp check_brackets("", []), do: true
  defp check_brackets("", _unmatched_brackets), do: false

  defp check_brackets("[" <> rest, stack) do
    check_brackets(rest, ["[" | stack])
  end
  defp check_brackets("]" <> rest, ["[" | rest_stack]) do
    check_brackets(rest, rest_stack)
  end
  defp check_brackets("]" <> _rest, _stack), do: false

  defp check_brackets("{" <> rest, stack) do
    check_brackets(rest, ["{" | stack])
  end
  defp check_brackets("}" <> rest, ["{" | rest_stack]) do
    check_brackets(rest, rest_stack)
  end
  defp check_brackets("}" <> _rest, _stack), do: false

  defp check_brackets("(" <> rest, stack) do
    check_brackets(rest, ["(" | stack])
  end
  defp check_brackets(")" <> rest, ["(" | rest_stack]) do
    check_brackets(rest, rest_stack)
  end
  defp check_brackets(")" <> _rest, _stack), do: false

  defp check_brackets(<<_first_char::binary-size(1), rest::binary>>, stack) do
    check_brackets(rest, stack)
  end
end
