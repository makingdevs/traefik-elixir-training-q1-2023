defmodule Traefik.Developer do
  @derive Jason.Encoder
  defstruct(id: 0, first_name: "", last_name: "", email: "", gender: "", ip_address: "")
end
