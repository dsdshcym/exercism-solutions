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
    |> handshake(code, 0b1)
    |> handshake(code, 0b10)
    |> handshake(code, 0b100)
    |> handshake(code, 0b1000)
    |> handshake(code, 0b10000)
  end

  defp handshake(actions, code, flag = 0b1) do
    if check(code, flag) do
      actions ++ ["wink"]
    else
      actions
    end
  end

  defp handshake(actions, code, flag = 0b10) do
    if check(code, flag) do
      actions ++ ["double blink"]
    else
      actions
    end
  end

  defp handshake(actions, code, flag = 0b100) do
    if check(code, flag) do
      actions ++ ["close your eyes"]
    else
      actions
    end
  end

  defp handshake(actions, code, flag = 0b1000) do
    if check(code, flag) do
      actions ++ ["jump"]
    else
      actions
    end
  end

  defp handshake(actions, code, flag = 0b10000) do
    if check(code, flag) do
      Enum.reverse(actions)
    else
      actions
    end
  end

  defp handshake(actions, code, _) do
    actions
  end

  defp check(code, flag) do
    (code &&& flag) == flag
  end
end
