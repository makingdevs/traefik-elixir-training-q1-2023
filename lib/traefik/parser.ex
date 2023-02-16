defmodule Traefik.Parser do
  alias Traefik.Conn

  def parse(request) do
    [main, params_string] = String.split(request, "\n\n")

    [request_line | headers_string] = String.split(main, "\n")

    [method, path, _protocol] = String.split(request_line, " ")

    params = URI.decode_query(params_string)

    headers = parse_headers(headers_string, %{})

    %Conn{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
    |> IO.inspect()
  end

  def parse_headers([head | tail], headers) do
    [header_name, header_value] = String.split(head, ": ")
    headers = Map.put(headers, header_name, header_value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers
end
