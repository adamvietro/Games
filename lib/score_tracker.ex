defmodule ScoreTracker do
  @moduledoc """
  Used to update and retrieve a players score.
  """
  use GenServer

  def start_link(args \\ 0) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def add_score(amount) do
    GenServer.cast(__MODULE__, {:push, amount})
  end

  def get_score() do
    GenServer.call(__MODULE__, :call)
  end

  @impl GenServer
  def init(args \\ 0) do
    {:ok, args}
  end

  @impl GenServer
  def handle_call(:call, _from, state) do
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:push, amount}, state) do
    new_state = state + amount
    {:noreply, new_state}
  end
end
