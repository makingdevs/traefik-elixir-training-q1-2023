defmodule Traefik.FibonacciServer do
  alias Traefik.Fibonacci
  alias Traefik.GenericServer

  @moduledoc """
  This is the module for SERVER
  """
  def start() do
    GenericServer.start(__MODULE__)
  end

  def handle_message({:compute, n}, state) do
    result = Fibonacci.sequence(n)
    {:ok, result, state}
  end
end
