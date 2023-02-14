defmodule Traefik.Parser do
  def parse(request) do
    [method, path, _protocol] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, response: "", status: nil}
  end
end
