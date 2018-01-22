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
    start_link()
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    send(account, :close)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    send(account, {:balance, self()})

    receive do
      {:ok, balance} -> balance
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    send(account, {:update, amount, self()})

    receive do
      :ok -> :ok
      {:error, reason} -> {:error, reason}
    end
  end

  defp start_link() do
    spawn_link(fn -> loop(%BankAccount{}) end)
  end

  defp loop(%BankAccount{closed: false} = state) do
    receive do
      {:balance, caller} ->
        send(caller, {:ok, state.balance})
        loop(state)

      {:update, amount, caller} ->
        send(caller, :ok)
        loop(%BankAccount{state | balance: state.balance + amount})

      :close ->
        loop(%BankAccount{state | closed: true})
    end
  end

  defp loop(%BankAccount{closed: true} = state) do
    receive do
      {:balance, caller} ->
        send(caller, {:error, :account_closed})
        loop(state)

      {:update, _amount, caller} ->
        send(caller, {:error, :account_closed})
        loop(state)

      :close ->
        loop(state)
    end
  end
end
