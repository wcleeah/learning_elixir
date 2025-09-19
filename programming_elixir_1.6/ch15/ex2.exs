defmodule Ch15.Ex2 do
  def send_it_back() do
    receive do
      {sender, token} -> send(sender, {:ok, token})
    end
  end

  def spawn_two() do
    pid1 = spawn(Ch15.Ex2, :send_it_back, [])
    pid2 = spawn(Ch15.Ex2, :send_it_back, [])

    send(pid1, {self(), "fred"})
    send(pid2, {self(), "betty"})

    receive do
      {:ok, token} -> IO.puts(token)
    end

    receive do
      {:ok, token} -> IO.puts(token)
    end
  end
end
