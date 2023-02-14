defmodule Traefik.Conn do
  defstruct method: "", path: "", response: "", status: nil

  def status(%__MODULE__{} = conn) do
    "#{conn.status} #{status_reason(conn.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }
    |> Map.get(code)
  end
end
