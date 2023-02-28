defmodule Traefik.FibonacciServer do
  alias Traefik.Fibonacci

  @moduledoc """
  This is the module for SERVER
  """
  def start() do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      {caller, n} when is_pid(caller) -> send(caller, {:ok, Fibonacci.sequence(n)})
    end
  end
end
