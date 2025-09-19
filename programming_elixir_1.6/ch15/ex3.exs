defmodule Ch15.Ex3 do
  def send_msg(parent) do
    send parent, "haha you suck"
    exit(:BOOM)
  end
  def start_link() do
    spawn_link(Ch15.Ex3, :send_msg, [self()])
    :timer.sleep(500)

    receive do
      msg -> IO.puts(inspect(msg))
    end
  end
  def start_monitor() do
    spawn_monitor(Ch15.Ex3, :send_msg, [self()])
    :timer.sleep(2000)

    receive do
      msg -> IO.puts(inspect(msg))
    end
  end
end

