defmodule Traefik.FibonacciServer do
  alias Traefik.Fibonacci

  @moduledoc """
  This is the module for SERVER
  """
  def start() do
    spawn(__MODULE__, :loop, [%{}])
  end

  def loop(state) do
    receive do
      {caller, :status} ->
        send(caller, state)
        loop(state)

      {caller, n} when is_pid(caller) and is_number(n) ->
        result = Fibonacci.sequence(n)
        send(caller, {:ok, n, result})
        state = Map.put(state, n, result)
        loop(state)

      :kill ->
        :killed

      _ ->
        loop(state)
    end
  end
end
