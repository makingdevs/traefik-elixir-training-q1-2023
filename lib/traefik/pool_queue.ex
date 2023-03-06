defmodule Traefik.PoolQueue do
  use GenServer

  def start_link(worker: {mod, fun, args}, n_workers: n_workers, name: name) do
    GenServer.start_link(__MODULE__, [{mod, fun, args}, n_workers], name: name)
  end

  def exec_compute(name, n) do
    {:ok, pid} = GenServer.call(name, :get_pid)
    GenServer.call(pid, {:compute, n})
  end

  def get(name), do: GenServer.call(name, __MODULE__, :get)
  def get_pid(name), do: GenServer.call(name, __MODULE__, :get_pid)

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
        {:ok, pid} = :erlang.apply(mod, fun, [args])
        ref = :erlang.monitor(:process, pid)
        %{ref: ref, pid: pid}
      end)

    # {:ok, %{queue: queue, worker: worker}}
    {:ok, queue}
  end

  def handle_call(:get, _from, queue), do: {:reply, {:ok, queue}, queue}

  def handle_call(:get_pid, _from, [%{pid: pid} = pid_ref | queue]),
    do: {:reply, {:ok, pid}, queue ++ [pid_ref]}

  def handle_cast({:in, pid}, queue) do
    ref = :erlang.monitor(:process, pid)
    {:noreply, queue ++ [%{ref: ref, pid: pid}]}
  end

  def handle_info({:DOWN, _ref, :process, pid, :killed}, queue) do
    IO.inspect("DOWN for #{pid}")

    queue
    |> Enum.find(fn %{pid: n_pid} -> n_pid == pid end)
    |> case do
      nil ->
        {:noreply, queue}

      %{pid: _pid, ref: _ref} = _elem ->
        # {:ok, pid} = :erlang.apply(mod, fun, [args])
        # ref = :erlang.monitor(:process, pid)

        # queue = queue -- ([elem] ++ [%{pid: pid, ref: ref}])
        # {:noreply, new_queue}
        {:noreply, queue}
    end
  end

  def handle_info({:EXIT, _pid, :killed}, queue) do
    {:noreply, queue}
  end
end
