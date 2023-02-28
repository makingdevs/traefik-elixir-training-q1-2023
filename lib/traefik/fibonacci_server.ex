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
      n -> Fibonacci.sequence(n)
    end
  end
end
