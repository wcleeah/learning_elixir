defmodule StackServer.Stash do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def change_to(new_state) do
    GenServer.cast(__MODULE__, {:change_to, new_state})
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(:get, _, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_cast({:change_to, new_state}, _current_state) do
    {:noreply, new_state}
  end
end
