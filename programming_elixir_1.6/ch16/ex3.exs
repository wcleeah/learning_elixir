# The book did not even talk about how to actually use agent
# It says in a few pages before: "A glipse of Agent", and then expect the reader to use it immediately in the next chapter
# What a great exercise, now i know how to use agent in the Node secion, without reading the Agent section
defmodule Ticker do
  @interval 2000
  @agent :agent

  def start() do
    {:ok, agent_pid} =
      Agent.start_link(fn -> [] end)

    spawn(__MODULE__, :send_ticks, [])

    :global.register_name(@agent, agent_pid)
  end

  def register(client) do
    Agent.update(:global.whereis_name(@agent), &[client | &1])
    IO.puts("Registered client #{inspect(client)}")
  end

  def send_ticks() do
    :timer.sleep(@interval)

    Agent.get(:global.whereis_name(@agent), & &1)
    |> Enum.each(&send_tick(&1))

    send_ticks()
  end

  def send_tick(client) do
    IO.puts("Ticker: Sending tick to client #{inspect(client)}")
    send(client, {:signal, "TICK"})
  end
end

defmodule Client do
  def start() do
    pid = spawn(__MODULE__, :tock, [])
    Ticker.register(pid)
  end

  def tock() do
    receive do
      {:signal, signal} ->
        IO.puts("Client (#{inspect(self())}): I say #{signal}, you say TOCK")
        tock()
    end
  end
end
