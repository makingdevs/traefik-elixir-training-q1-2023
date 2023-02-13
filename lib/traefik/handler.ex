defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _protocol] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, response: ""}
  end

  def route(conn) do
    %{conn | response: "Hello world!😘"}
  end

  def format_response(conn) do
    """
    HTTP/1.1 200 OK
    Host: some.com
    User-Agent: telnet
    Content-Lenght: #{String.length(conn.response)}
    Accept: */*

    #{conn.response}
    """
  end
end

request = """
GET /hello HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet


"""

_response = """
HTTP/1.1 200 OK
Host: some.com
User-Agent: telnet
Accept: */*

Hello world
"""

IO.puts(Traefik.Handler.handle(request))
