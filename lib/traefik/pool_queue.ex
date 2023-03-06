defmodule Traefik.PoolQueue do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def exec_compute(n) do
    {:ok, pid} = GenServer.call(__MODULE__, :get_pid)
    GenServer.call(pid, {:compute, n})
  end

  def get, do: GenServer.call(__MODULE__, :get)
  def get_pid, do: GenServer.call(__MODULE__, :get_pid)

  def add_pid(worker_module) do
    {:ok, pid} = :erlang.apply(worker_module, :start_link, [[]])
    GenServer.cast(__MODULE__, {:in, pid})
  end

  def init([]), do: {:ok, []}
  def handle_call(:get, _from, queue), do: {:reply, {:ok, queue}, queue}
  def handle_call(:get_pid, _from, [pid | queue]), do: {:reply, {:ok, pid}, queue ++ [pid]}
  def handle_cast({:in, pid}, queue), do: {:noreply, queue ++ [pid]}
end
