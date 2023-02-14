defmodule Traefik.Parser do
  alias Traefik.Conn

  def parse(request) do
    [method, path, _protocol] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conn{method: method, path: path}
  end
end
