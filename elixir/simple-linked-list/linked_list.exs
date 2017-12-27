defmodule LinkedList do
  defstruct value: nil, next: nil, length: 0

  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %LinkedList{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list = %LinkedList{length: length}, elem) do
    %LinkedList{value: elem, next: list, length: length + 1}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(%LinkedList{length: length}), do: length

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(%LinkedList{length: 0}), do: true
  def empty?(%LinkedList{}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{length: 0}), do: {:error, :empty_list}
  def peek(%LinkedList{value: head}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%LinkedList{length: 0}), do: {:error, :empty_list}
  def tail(%LinkedList{value: _, next: tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(%LinkedList{length: 0}), do: {:error, :empty_list}
  def pop(%LinkedList{value: head, next: tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: new()
  def from_list([head | tail]) do
    tail
    |> from_list()
    |> push(head)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(%LinkedList{length: 0}), do: []
  def to_list(%LinkedList{value: head, next: tail}), do: [head | to_list(tail)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list = %LinkedList{length: 0}), do: list
  def reverse(%LinkedList{} = list) do
    list
    |> to_list
    |> Enum.reverse()
    |> from_list
  end
end
