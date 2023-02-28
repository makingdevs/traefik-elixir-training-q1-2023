defmodule Traefik.SimpleServer do
  def start(request) do
    parent = self()
    pid = spawn(__MODULE__, :loop, [parent])
    send(pid, {parent, :call, request})
  end

  def loop(pid) do
    receive do
      {^pid, :call, request} ->
        Traefik.Handler.handle(request)
        |> IO.inspect(label: "RESPONSE")
    end
  end
end
