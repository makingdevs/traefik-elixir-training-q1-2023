defmodule Traefik.FibonacciServer do
  alias Traefik.Fibonacci
  alias Traefik.GenericServer

  @moduledoc """
  This is the module for SERVER
  """
  def start() do
    GenericServer.start(__MODULE__)
  end

  # def loop(state) do
  #   receive do
  #     {caller, :status} ->
  #       send(caller, state)
  #       loop(state)

  #     {caller, n} when is_pid(caller) and is_number(n) ->
  #       result =
  #         case Map.get(state, n) do
  #           nil -> Fibonacci.sequence(n)
  #           r -> r
  #         end

  #       send(caller, {:ok, n, result})

  #       state
  #       |> Map.put_new(n, result)
  #       |> loop()

  #     :kill ->
  #       :killed

  #     _ ->
  #       loop(state)
  #   end
  # end
end
