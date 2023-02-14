defmodule Traefik.Plugs do
  def rewrite_path(%{path: "/redirectme"} = conn) do
    %{conn | path: "/all"}
  end

  def rewrite_path(conn), do: conn

  def log(conn), do: IO.inspect(conn, label: "Logger")

  def track(%{status: 404, path: path} = conn) do
    IO.inspect("Warn ✊ path #{path} not found")
    conn
  end

  def track(conn), do: conn
end
