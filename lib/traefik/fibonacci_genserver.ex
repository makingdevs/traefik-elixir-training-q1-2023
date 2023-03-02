defmodule Traefik.FibonacciGenServer do
  use GenServer

  alias Traefik.Fibonacci

  def init(_), do: {:ok, %{}}

  def handle_call({:compute, n}, _parent, state) when is_number(n) and n > 0 do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        r -> r
      end

    new_state = Map.put_new(state, n, result)
    {:reply, result, new_state}
  end

  def handle_cast({:compute, n}, state) when is_number(n) and n > 0 do
    result =
      case Map.get(state, n) do
        nil -> Fibonacci.sequence(n)
        r -> r
      end

    new_state = Map.put_new(state, n, result)
    {:noreply, new_state}
  end

  def handle_info(msg, state) do
    IO.inspect(binding())
    {:noreply, state}
  end
end
