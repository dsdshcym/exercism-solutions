defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(&parse_each/1)
    |> Enum.join()
    |> wrap_unordered_lists()
  end

  defp parse_each(m) do
    m
    |> parse_bold()
    |> parse_italics()
    |> parse_whole_line()
  end

  defp parse_bold(m) do
    m
    |> String.replace(~r/__(.+)__/, wrap_in_tag("\\1", "strong"))
  end

  defp parse_italics(m) do
    m
    |> String.replace(~r/_(.+)_/, wrap_in_tag("\\1", "em"))
  end

  defp parse_whole_line(m) do
    cond do
      header?(m) -> parse_header(m)
      list?(m) -> parse_list(m)
      true -> parse_paragraph(m)
    end
  end

  defp header?(m), do: String.match?(m, ~r/#+ /)

  defp parse_header(m) do
    %{"level" => level, "header" => header} =
      Regex.named_captures(~r/^(?<level>#+) (?<header>.*)/, m)

    header_tag = "h#{String.length(level)}"
    header |> wrap_in_tag(header_tag)
  end

  defp list?(m), do: String.match?(m, ~r/^\* /)

  defp parse_list(m) do
    m
    |> String.replace(~r/\* (.+)/, wrap_in_tag("\\1", "li"))
  end

  defp parse_paragraph(m) do
    m
    |> wrap_in_tag("p")
  end

  defp wrap_unordered_lists(string) do
    string
    |> String.replace(~r/(<li>.+<\/li>)+/, wrap_in_tag("\\0", "ul"))
  end

  defp wrap_in_tag(string, tag) do
    open_tag = "<#{tag}>"
    close_tag = "</#{tag}>"

    [open_tag, string, close_tag]
    |> Enum.join()
  end
end
