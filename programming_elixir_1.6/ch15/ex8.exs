defmodule Ch15.Ex8.Fib do
  def start_cal(parent) do
    send(parent, {:ready, self()})

    receive do
      {:process, num} ->
        send(parent, {:answer, cal(num), num})
        start_cal(parent)

      {:shutdown} ->
        exit(:BOOOM)
    end
  end

  defp cal(0) do
    0
  end

  defp cal(1) do
    1
  end

  defp cal(n) do
    cal(n - 1) + cal(n - 2)
  end
end

defmodule Ch15.Ex8.Scheduler do
  def run(num_processes, module, func, list) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_jobs(list, [])
  end

  defp schedule_jobs(processes, list, results) do
    receive do
      {:ready, pid} when length(list) > 0 ->
        [head | tail] = list
        send(pid, {:process, head})
        schedule_jobs(processes, tail, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_jobs(List.delete(processes, pid), list, results)
        else
          results
        end

      {:answer, answer, num} ->
        schedule_jobs(processes, list, [{answer, num} | results])
    end
  end
end

to_process = List.duplicate(37, 30)

Enum.each(1..20, fn num_processes ->
  {time, result} =
    :timer.tc(
      Ch15.Ex8.Scheduler,
      :run,
      [num_processes, Ch15.Ex8.Fib, :start_cal, to_process]
    )

  if num_processes == 1 do
    IO.puts(inspect(result))
  end

  :io.format("~2B    ~.2f~n", [num_processes, time / 1_000_000.0])
end)
