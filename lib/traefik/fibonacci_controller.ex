defmodule Traefik.FiboController do
  alias Traefik.Conn
  alias Traefik.Fibonacci

  def compute(%Conn{} = conn, %{"n" => n} = params) do
    result = Fibonacci.sequence(n)
    response = "Result #{result}"
    %{conn | response: response, status: 201}
  end
end
