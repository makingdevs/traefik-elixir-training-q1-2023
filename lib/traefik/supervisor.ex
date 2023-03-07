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
           name: PoolFibonacci_1
         ]},
        id: :pool_queue_1
      ),
      Supervisor.child_spec(
        {Traefik.PoolQueue,
         [
           worker: {Traefik.FibonacciGenServer, :start_link, []},
           n_workers: 3,
           name: PoolFibonacci_2
         ]},
        id: :pool_queue_2
      )
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
