defmodule Ticker do
  @interval 2000
  @name :ticker

  def start() do
    pid = spawn(__MODULE__, :schedule, [[]])

    :global.register_name(@name, pid)
  end

  def register(client) do
    send(:global.whereis_name(@name), {:register, client})
  end

  def schedule(clients) do
    receive do
      {:register, client} ->
        IO.puts("Registered client #{inspect(client)}")
        schedule([client | clients])

    after
      @interval ->
        Enum.each(clients, &send_tick(&1))
        schedule(clients)
    end
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
