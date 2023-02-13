defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def parse(request) do
    %{method: "GET", path: "/hello", response: ""}
  end

  def route(conn) do
    %{method: "GET", path: "/hello", response: "Hello world"}
  end

  def format_response(conn) do
    """
    HTTP/1.1 200 OK
    Host: some.com
    User-Agent: telnet
    Accept: */*

    Hello world
    """
  end
end

request = """
GET /hello HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet


"""

response = """
HTTP/1.1 200 OK
Host: some.com
User-Agent: telnet
Accept: */*

Hello world
"""

IO.puts(request)
