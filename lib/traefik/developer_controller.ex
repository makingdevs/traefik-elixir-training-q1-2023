defmodule Traefik.DeveloperController do
  alias Traefik.Conn
  alias Traefik.Organization

  @templates_location Path.expand("../../templates", __DIR__)

  def index(%Conn{} = conn) do
    developers = Organization.list_developers(%{limit: 5, offset: 0})

    render(conn, "index.eex", developers: developers)
  end

  def show(%Conn{} = conn, %{"id" => id}) do
    developer = Organization.get_developer(id)

    render(conn, "show.eex", developer: developer)
  end

  defp render(conn, template, bindings) do
    response =
      @templates_location
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conn | response: response, status: 200}
  end
end
