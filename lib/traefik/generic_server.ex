defmodule Traefik.GenericServer do
  def start(module) do
    spawn(__MODULE__, :loop, [module, %{}])
  end

  def loop(module, state) do
    receive do
      {message, pid} ->
        send(pid, {:ok, {module, message, state}})
        loop(module, state)

      :kill ->
        :killed

      _ ->
        loop(module, state)
    end
  end
end
