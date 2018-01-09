defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.flat_map(&invert_value_words_map/1)
    |> Enum.into(%{})
  end
  
  defp invert_value_words_map({value, words}) do
      words
      |> Enum.map(&String.downcase/1)
      |> Enum.map(&{&1, value})
  end
end
