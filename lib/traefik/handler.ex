defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def parse(_request) do
    %{method: "GET", path: "/hello", response: ""}
  end

  def route(_conn) do
    %{method: "GET", path: "/hello", response: "Hello world"}
  end

  def format_response(_conn) do
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

_response = """
HTTP/1.1 200 OK
Host: some.com
User-Agent: telnet
Accept: */*

Hello world
"""

IO.puts(Traefik.Handler.handle(request))
