defmodule Traefik.PoolQueue do
  use GenServer

  def start_link(worker: {mod, fun, args}, n_workers: n_workers, name: name) do
    GenServer.start_link(__MODULE__, [{mod, fun, args}, n_workers], name: name)
  end

  def exec_compute(name, n) do
    {:ok, pid} = GenServer.call(name, :get_pid)
    GenServer.call(pid, {:compute, n})
  end

  def get(name), do: GenServer.call(name, :get)
  def get_pid(name), do: GenServer.call(name, :get_pid)

  def add_pid(worker_module) do
    {:ok, pid} = :erlang.apply(worker_module, :start_link, [[]])
    GenServer.cast(__MODULE__, {:in, pid})
  end

  def init([{mod, fun, args} = worker, n_workers]) do
    Process.flag(:trap_exit, true)

    queue =
      1..n_workers
      |> Enum.to_list()
      |> Enum.map(fn _ ->
        {:ok, pid} = apply(mod, fun, [args])
        ref = :erlang.monitor(:process, pid)
        %{ref: ref, pid: pid}
      end)

    {:ok, %{queue: queue, worker: worker}}
  end

  def handle_call(:get, _from, %{queue: queue, worker: _worker} = state),
    do: {:reply, {:ok, queue}, state}

  def handle_call(:get_pid, _from, %{queue: [%{pid: pid} = pid_ref | queue], worker: worker}),
    do: {:reply, {:ok, pid}, %{queue: queue ++ [pid_ref], worker: worker}}

  def handle_cast({:in, pid}, %{queue: queue, worker: worker}) do
    ref = :erlang.monitor(:process, pid)
    {:noreply, %{queue: queue ++ [%{ref: ref, pid: pid}], worker: worker}}
  end

  def handle_info({:DOWN, _ref, :process, pid, reason}, %{queue: queue, worker: {mod, fun, args}}) do
    IO.inspect("DOWN for #{inspect(pid)} because #{inspect(reason)}")

    queue
    |> Enum.find(fn %{pid: n_pid} -> n_pid == pid end)
    |> case do
      nil ->
        {:noreply, queue}

      %{pid: _pid, ref: _ref} = elem ->
        {:ok, new_pid} = apply(mod, fun, [args])
        IO.inspect("Replace #{inspect(pid)} for #{inspect(new_pid)}")
        new_ref = :erlang.monitor(:process, pid)

        queue =
          queue
          |> Kernel.--([elem])
          |> Kernel.++([%{pid: new_pid, ref: new_ref}])

        {:noreply, %{queue: queue, worker: {mod, fun, args}}}
    end
  end

  def handle_info({:EXIT, _pid, :killed}, queue) do
    {:noreply, queue}
  end
end
