defmodule Traefik.SimpleServer do
  def start(socket) do
    spawn(Traefik.HttpServer, :serve, [socket])
  end
end
