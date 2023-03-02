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
    {:noreply, state}
  end

  def handle_cast({:compute, n}, _parent, state) when is_number(n) and n > 0 do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        r -> r
      end

    new_state = Map.put_new(state, n, result)
    {:noreply, new_state}
  end

  def handle_call({:compute, n}, state) when is_number(n) and n > 0 do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        r -> r
      end

    new_state = Map.put_new(state, n, result)
    {:reply, result, new_state}
  end

  def handle_info(message, parent, state) do
    IO.inspect(binding())
    {:noreply, state}
  end
end
