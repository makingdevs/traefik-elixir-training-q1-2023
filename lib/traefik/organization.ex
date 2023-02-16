defmodule Traefik.Organization do
  alias Traefik.Developer
  @devs_file Path.expand("./") |> Path.join("MOCK_DATA.csv")

  def list_developers do
    @devs_file
    |> File.read!()
    |> String.split("\n")
    |> Kernel.tl()
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&transform_developer/1)
  end

  defp transform_developer([id, first_name, last_name, email, gender, ip_address]) do
    %Developer{
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      gender: gender,
      ip_address: ip_address
    }
  end

  defp transform_developer(_), do: nil
end
