defmodule Traefik.GenericServer do
  def start(module) do
    spawn(__MODULE__, :loop, [module, %{}])
  end

  def loop(module, state) do
    receive do
      {pid, message} ->
        {:ok, result, state} = module.handle_message(message, state)
        send(pid, {:ok, {module, message, result, state}})
        loop(module, state)

      :kill ->
        :killed

      _ ->
        loop(module, state)
    end
  end
end
