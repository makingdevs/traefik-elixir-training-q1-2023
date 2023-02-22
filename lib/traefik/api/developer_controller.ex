defmodule Traefik.Api.DeveloperController do
  alias Traefik.Conn

  def index(%Conn{} = conn, _params \\ %{}) do
    json =
      Traefik.Organization.list_developers(%{limit: 10, offset: 0})
      |> Jason.encode!()

    %{conn | status: 200, response: json, content_type: "application/json"}
  end
end
