defmodule Traefik.Supervisor do
  use Supervisor

  def init(_) do
    children = [
      Traefik.FibonacciGenServer,
      Traefik.ClockServer
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
