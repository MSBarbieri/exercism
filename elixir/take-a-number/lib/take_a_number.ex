defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end
  defp loop(start) do
    receive do
      {:report_state, pid} ->
        send(pid, start)
        loop(start)
      {:take_a_number, pid} ->
        send(pid, start+1)
        loop(start + 1)
      :stop -> nil
      _ -> loop(start)
    end
  end
end
