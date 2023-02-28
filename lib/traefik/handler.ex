defmodule Traefik.Handler do
  @moduledoc """
  Handles all the HTTP requests.
  """

  @files_path Path.expand("../../pages", __DIR__)

  import Traefik.Plugs, only: [rewrite_path: 1, log: 1, track: 1]
  import Traefik.Parser, only: [parse: 1]
  alias Traefik.Conn
  alias Traefik.{DeveloperController, FibonacciController}

  @doc """
  Handle a single request, transforms into response.
  """
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    # |> log()
    |> route()
    |> track()
    |> format_response()
  end

  def route(%Conn{method: "GET", path: "/crash"} = _conn) do
    raise "Crash server!!!"
  end

  def route(%Conn{method: "POST", path: "/fibonacci", params: params} = conn) do
    FibonacciController.compute(conn, params)
  end

  def route(%Conn{method: "GET", path: "/freeze/" <> freeze} = conn) do
    freeze |> String.to_integer() |> :timer.sleep()
    %{conn | status: 200, response: "unfreeze !!!!"}
  end

  def route(%Conn{method: "GET", path: "/hello"} = conn) do
    %{conn | status: 200, response: "Hello World!!!"}
  end

  def route(%Conn{method: "GET", path: "/world"} = conn) do
    %{conn | status: 200, response: "Hello MakingDevs and all devs"}
  end

  def route(%Conn{method: "GET", path: "/developer/" <> id} = conn) do
    DeveloperController.show(conn, %{"id" => id})
  end

  def route(%Conn{method: "GET", path: "/developer"} = conn) do
    DeveloperController.index(conn)
  end

  def route(%Conn{method: "GET", path: "/api/developer"} = conn) do
    Traefik.Api.DeveloperController.index(conn)
  end

  def route(%Conn{method: "POST", path: "/new", params: params} = conn) do
    %{
      conn
      | status: 201,
        response: "A new element created: #{params["name"]} from #{params["company"]}"
    }
  end

  def route(%Conn{method: "GET", path: "/about"} = conn) do
    @files_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conn)
  end

  def route(%Conn{method: _method, path: path} = conn) do
    %{conn | status: 404, response: "No #{path} found!!!"}
  end

  def handle_file({:ok, content}, %Conn{} = conn),
    do: %{conn | status: 200, response: content}

  def handle_file({:error, reason}, %Conn{} = conn),
    do: %{conn | status: 404, response: "File not found for #{inspect(reason)}"}

  def format_response(%Conn{} = conn) do
    """
    HTTP/1.1 #{Conn.status(conn)}
    Host: some.com
    User-Agent: telnet
    Content-Type: #{conn.content_type}
    Content-Lenght: #{String.length(conn.response)}
    Accept: */*

    #{conn.response}
    """
  end
end
