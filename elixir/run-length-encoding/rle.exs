defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    _encode(string, 0, "")
  end

  defp _encode("", n, char), do: _encode_char(n, char)
  defp _encode(<<match::binary-size(1), rest::binary>>, n, match) do
    _encode(rest, n + 1, match)
  end
  defp _encode(<<char::binary-size(1), rest::binary>>, n, non_match) do
    _encode_char(n, non_match) <> _encode(rest, 1, char)
  end

  defp _encode_char(0, _char), do: ""
  defp _encode_char(1, char), do: char
  defp _encode_char(n, char), do: "#{n}#{char}"

  @spec decode(String.t) :: String.t
  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r/(\d*)([^\d]{1})/, string)
    |> Enum.map(&cleanup_match_results/1)
    |> Enum.map(&match_to_string/1)
    |> Enum.join()
  end

  defp cleanup_match_results([_match, "", char]), do: {char, 1}
  defp cleanup_match_results([_match, count, char]), do: {char, String.to_integer(count)}

  defp match_to_string({_, 0}), do: ""
  defp match_to_string({char, count}) do
    char <> match_to_string({char, count - 1})
  end
end
