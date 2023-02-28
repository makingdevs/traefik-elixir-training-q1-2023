defmodule Traefik.Fibonacci do
  @moduledoc """
  This is the module for the SEQUENCE
  """
  def sequence(0), do: 0
  def sequence(1), do: 1
  def sequence(n), do: sequence(n - 1) + sequence(n - 2)
end
