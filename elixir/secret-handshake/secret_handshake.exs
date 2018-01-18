defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> handshake(check(code, 0b1), append_action_fn("wink"))
    |> handshake(check(code, 0b10), append_action_fn("double blink"))
    |> handshake(check(code, 0b100), append_action_fn("close your eyes"))
    |> handshake(check(code, 0b1000), append_action_fn("jump"))
    |> handshake(check(code, 0b10000), &Enum.reverse/1)
  end

  defp handshake(actions, true, transformation) do
    transformation.(actions)
  end

  defp handshake(actions, false, _transformation) do
    actions
  end

  defp append_action_fn(action) do
    fn actions -> actions ++ [action] end
  end

  defp check(code, flag) do
    (code &&& flag) == flag
  end
end
