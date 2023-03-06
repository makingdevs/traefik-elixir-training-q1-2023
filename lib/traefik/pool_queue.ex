defmodule Traefik.PoolQueue do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]), do: {:ok, []}
  def handle_call(:get, _from, queue), do: {:reply, {:ok, queue}, queue}
  def handle_call(:get_pid, _from, [pid | queue]), do: {:reply, {:ok, pid}, queue ++ [pid]}
  def handle_cast({:in, pid}, queue), do: {:noreply, queue ++ [pid]}
end
