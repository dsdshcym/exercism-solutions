defmodule BankAccount do
  defstruct closed: false, balance: 0

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> %BankAccount{} end)

    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    account
    |> Agent.cast(&%BankAccount{&1 | closed: true})
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    account
    |> Agent.get(fn
      %BankAccount{closed: false, balance: balance} -> balance
      %BankAccount{closed: true} -> {:error, :account_closed}
    end)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    account
    |> Agent.get_and_update(fn
      %BankAccount{closed: false, balance: balance} = state ->
        {:ok, %BankAccount{state | balance: balance + amount}}

      %BankAccount{closed: true} = state ->
        {{:error, :account_closed}, state}
    end)
  end
end
