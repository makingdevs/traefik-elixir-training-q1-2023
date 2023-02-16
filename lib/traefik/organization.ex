defmodule Traefik.Organization do
  alias Traefik.Developer
  @devs_file Path.expand("./") |> Path.join("MOCK_DATA.csv")

  def list_developers do
    @devs_file
    |> File.read()
    |> elem(1)
    |> String.split("\n")
    |> Kernel.tl()
    |> Enum.map(fn e -> String.split(e, ",") end)
    |> Enum.map(fn e -> transform_developer(e) end)
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
