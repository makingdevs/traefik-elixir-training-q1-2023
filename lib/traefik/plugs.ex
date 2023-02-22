defmodule Traefik.Plugs do
  alias Traefik.Conn

  @moduledoc """
  Some functions for extra information about requests
  """

  def rewrite_path(%Conn{path: "/redirectme"} = conn) do
    %{conn | path: "/all"}
  end

  def rewrite_path(%Conn{} = conn), do: conn

  def log(%Conn{} = conn) do
    show_log(conn, Mix.env())
    conn
  end

  @doc """
  Shows the request when the env is active
  """
  def track(%Conn{status: 404, path: _path} = conn) do
    show_track(conn, Mix.env())
    conn
  end

  def track(%Conn{} = conn), do: conn

  defp show_log(conn, :dev), do: IO.inspect(conn)
  defp show_log(_conn, _), do: :ok

  defp show_track(_conn, :test), do: :ok
  defp show_track(conn, _), do: IO.inspect(conn)
end
