defmodule Traefik.FibonacciServer do
  alias Traefik.Fibonacci
  alias Traefik.GenericServer

  @moduledoc """
  This is the module for SERVER
  """
  def start() do
    GenericServer.start(__MODULE__, self(), %{})
  end

  def handle_cast(:status, parent, state) do
    IO.inspect(parent)
    IO.inspect(self())
    {:ok, state, state}
  end

  def handle_cast({:compute, n}, _parent, state) do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        r -> r
      end

    new_state = Map.put_new(state, n, result)
    {:ok, result, new_state}
  end
end
