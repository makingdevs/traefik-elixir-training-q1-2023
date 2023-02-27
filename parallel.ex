defmodule Parallel do
  def pmap(collection, fun) do
    collection
    |> Enum.map(&spawn_process(&1, self(), fun))
    |> Enum.map(&await/1)
  end

  defp spawn_process(n, parent, fun) do
    spawn(fn ->
      send(parent, {self(), fun.(n)})
    end)
  end

  defp await(pid) do
    receive do
      {^pid, result} -> result
    end
  end
end
