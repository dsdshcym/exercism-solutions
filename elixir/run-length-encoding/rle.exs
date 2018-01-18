defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(~r/(.)\1*/, string)
    |> Enum.map(&cleanup_encode_match_results/1)
    |> Enum.map(&encode_substring/1)
    |> Enum.join()
  end

  defp cleanup_encode_match_results([substring, _]), do: substring

  defp encode_substring(""), do: ""
  defp encode_substring(<<char::binary-size(1)>>), do: char

  defp encode_substring(string) do
    char = String.first(string)
    count = String.length(string)
    "#{count}#{char}"
  end

  @spec decode(String.t()) :: String.t()
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
