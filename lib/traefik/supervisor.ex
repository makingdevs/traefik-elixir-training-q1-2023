defmodule Traefik.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_) do
    children = [
      Traefik.ClockServer,
      {Traefik.NodeQueue, [name: NodeQueue]},
      Supervisor.child_spec(
        {Traefik.PoolQueue,
         [
           worker: {Traefik.FibonacciGenServer, :start_link, []},
           n_workers: 5,
           name: PoolFibonacci
         ]},
        id: :pool_queue
      )
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
