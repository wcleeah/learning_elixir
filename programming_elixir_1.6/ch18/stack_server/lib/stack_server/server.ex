defmodule StackServer.Server do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  # NOTE:
  # the question specifically said, if the initial_state is [5,6,7], the pop sequence should be 5, 6, 7
  # you would think a stack is LIFO, but turns out
  # this initial_state assumes the user knows the stack is revered, coz elixir can do cons operation on lists 
  # thats also why i am confused at first, this is not a stack, it is a queue
  def init(_init_state) do
    # This is super duper dangenrous, and this is the way the book code the section
    # Do not want to spend time here, but probably the best to check if the stash server is up
    # if not, fallback to init state
    # for a section that teaches how to handle lifecycle, this really sucks
    stash = StackServer.Stash.get()
    {:ok, stash}
  end

  def handle_call(:pop, _, current_state) do
    [head | tail] = current_state

    {:reply, head, tail}
  end

  def handle_cast({:push, element}, current_state) do
    :timer.sleep(10000)
    {:noreply, [element | current_state]}
  end

  def terminate(_reason, current_state) do
    StackServer.Stash.change_to(current_state)
  end
end
