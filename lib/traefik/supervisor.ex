defmodule Traefik.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_) do
    children = [
      Traefik.FibonacciGenServer,
      Traefik.ClockServer
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
