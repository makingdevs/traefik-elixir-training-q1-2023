defmodule Traefik.Plugs do
  alias Traefik.Conn

  def rewrite_path(%Conn{path: "/redirectme"} = conn) do
    %{conn | path: "/all"}
  end

  def rewrite_path(%Conn{} = conn), do: conn

  def log(%Conn{} = conn), do: IO.inspect(conn, label: "Logger")

  def track(%Conn{status: 404, path: path} = conn) do
    IO.inspect("Warn ✊ path #{path} not found")
    conn
  end

  def track(%Conn{} = conn), do: conn
end
