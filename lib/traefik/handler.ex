defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> log()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _protocol] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, response: "", status: nil}
  end

  def log(conn), do: IO.inspect(conn, label: "Logger")

  def route(conn) do
    route(conn, conn.method, conn.path)
  end

  def route(conn, "GET", "/hello") do
    %{conn | status: 200, response: "Hello World!!!"}
  end

  def route(conn, "GET", "/world") do
    %{conn | status: 200, response: "Hello MakingDevs and all devs"}
  end

  def route(conn, _method, path) do
    %{conn | status: 404, response: "No #{path} found!!!"}
  end

  def format_response(conn) do
    """
    HTTP/1.1 #{conn.status} #{status_reason(conn.status)}
    Host: some.com
    User-Agent: telnet
    Content-Lenght: #{String.length(conn.response)}
    Accept: */*

    #{conn.response}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }
    |> Map.get(code)
  end
end

request_1 = """
GET /hello HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet


"""

IO.puts(Traefik.Handler.handle(request_1))
IO.puts("-------------------------#")

request_2 = """
GET /world HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet


"""

IO.puts(Traefik.Handler.handle(request_2))
IO.puts("-------------------------#")

request_3 = """
GET /not-found HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet


"""

IO.puts(Traefik.Handler.handle(request_3))
