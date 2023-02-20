defmodule Traefik.DeveloperController do
  alias Traefik.Conn
  alias Traefik.Organization

  def index(%Conn{} = conn) do
    developers =
      Organization.list_developers(%{limit: 5, offset: 0})
      |> Enum.map(&"<li>#{&1.id} - #{&1.first_name}</li> ")
      |> Enum.join("\n")

    developers = """
    <ul>
    #{developers}
    </ul>
    """

    %{conn | response: developers, status: 200}
  end

  def show(%Conn{} = conn, %{"id" => id}) do
    developer = Organization.get_developer(id)

    dev_response = """
    #{developer.id} - #{developer.first_name} - #{developer.last_name} - #{developer.email}
    """

    %{conn | response: dev_response, status: 200}
  end
end
