defmodule Traefik.Parser do
  alias Traefik.Conn

  def parse(request) do
    [main, params_string] = String.split(request, "\n\n")

    [request_line | _headers] = String.split(main, "\n")

    [method, path, _protocol] = String.split(request_line, " ")

    params = URI.decode_query(params_string)

    %Conn{method: method, path: path, params: params}
  end
end
