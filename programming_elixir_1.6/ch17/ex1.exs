defmodule Stack do
  use GenServer

  # NOTE:
  # the question specifically said, if the initial_state is [5,6,7], the pop sequence should be 5, 6, 7
  # you would think a stack is LIFO, but turns out
  # this initial_state assumes the user knows the stack is revered, coz elixir can do cons operation on lists 
  # thats also why i am confused at first, this is not a stack, it is a queue
  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(:pop, _, current_state) do
    [head | tail] = current_state

    {:reply, head, tail}
  end

  def handle_cast({:push, element}, current_state) do
    :timer.sleep(10000)
    {:noreply, [element | current_state]}
  end
end
