defmodule Traefik.ParserTest do
  use ExUnit.Case
  # doctest Traefik

  test "parses the headers from a request into a map" do
    headers_string = ["Accept: */*", "Connection: keep-alive"]
    headers = Traefik.Parser.parse_headers(headers_string, %{})
    assert headers == %{"Accept" => "*/*", "Connection" => "keep-alive"}
  end

  test "parses the params from a request into a map" do
    params_string = "a=1&b=2&c=3"
    params = Traefik.Parser.parse_params("application/x-www-form-urlencoded", params_string)
    assert params == %{"a" => "1", "b" => "2", "c" => "3"}
  end
end
