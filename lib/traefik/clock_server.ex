defmodule Traefik.ClockServer do
  use GenServer

  @interval 3000

  def init(_) do
    Process.send_after(self(), :tick, @interval)
    {:ok, %{interval: @interval, turn_on: true}}
  end

  def handle_cast({:switch}, state) do
    {:noreply, %{state | turn_on: !state.turn_on}}
  end

  def handle_info(_msg, %{turn_on: false, interval: interval} = state) do
    Process.send_after(self(), :tick, interval)
    {:noreply, state}
  end

  def handle_info(_msg, %{interval: interval} = state) do
    DateTime.utc_now() |> DateTime.to_string() |> IO.puts()
    IO.inspect(binding())
    Process.send_after(self(), :tick, interval)
    {:noreply, state}
  end
end
