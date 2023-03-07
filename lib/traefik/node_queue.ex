defmodule Traefik.NodeQueue do
  use GenServer

  alias Traefik.{PoolQueue, FibonacciGenServer}

  def start_link(name: name) do
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def init([]) do
    :net_kernel.monitor_nodes(true)
    {:ok, %{nodes: []}}
  end

  def handle_info({:nodeup, node}, %{nodes: nodes}) do
    :abcast = :c.nl(FibonacciGenServer)
    :abcast = :c.nl(Traefik.Fibonacci)

    PoolQueue.add_remote_pid(PoolFibonacci, node, 3)

    {:noreply, %{nodes: nodes ++ [node]}}
    |> IO.inspect(label: "Add node")
  end

  def handle_info({:nodedown, node}, %{nodes: nodes}) do
    {:noreply, %{nodes: nodes -- [node]}}
    |> IO.inspect(label: "Remove node")
  end
end
