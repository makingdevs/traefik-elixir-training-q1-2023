defmodule Traefik.ParserTest do
  use ExUnit.Case
  # doctest Traefik

  test "parses the headers from a request into a map" do
    headers_string = ["Accept: */*", "Connection: keep-alive"]
    headers = Traefik.Parser.parse_headers(headers_string, %{})
    assert headers == %{"Accept" => "*/*", "Connection" => "keep-alive"}
  end
end
