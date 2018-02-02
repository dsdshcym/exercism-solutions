defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro graph(do: ast) do
    ast |> build_graph() |> Macro.escape()
  end

  def build_graph({:__block__, _, statements}) do
    statements
    |> Enum.map(fn statement -> build_graph(statement) end)
    |> Enum.reduce(%Graph{}, &merge_graph/2)
  end

  def build_graph({:graph, _, [attributes]}) do
    %Graph{attrs: validate_attributes(attributes)}
  end

  def build_graph({:--, _, [{from, _, _}, {to, _, nil}]}) do
    %Graph{edges: [{from, to, []}]}
  end

  def build_graph({:--, _, [{from, _, _}, {to, _, [attributes]}]}) do
    %Graph{edges: [{from, to, validate_attributes(attributes)}]}
  end

  def build_graph({node, _, nil}) do
    %Graph{nodes: [{node, []}]}
  end

  def build_graph({node, _, [attributes]}) do
    %Graph{nodes: [{node, validate_attributes(attributes)}]}
  end

  def build_graph(_), do: raise(ArgumentError)

  defp merge_graph(graph1, graph2) do
    Map.merge(graph1, graph2, fn
      key, v1, v2 when key in [:attrs, :edges, :nodes] -> Enum.sort(v1 ++ v2)
      _key, v1, v2 -> v1 || v2
    end)
  end

  defp validate_attributes(attributes) do
    if Keyword.keyword?(attributes) do
      attributes
    else
      raise ArgumentError
    end
  end
end
