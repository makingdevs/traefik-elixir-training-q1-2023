# client() ->
#   SomeHostInNet = "localhost", % to make it runnable on one machine
#   {ok, Sock} = gen_tcp:connect(SomeHostInNet, 5678,
#     [binary, {packet, 0}]),
#     ok = gen_tcp:send(Sock, "Some Data"),
#     ok = gen_tcp:close(Sock).
#
# server() ->
# {ok, LSock} = gen_tcp:listen(5678, [binary, {packet, 0},
#   {active, false}]),
#   {ok, Sock} = gen_tcp:accept(LSock),
#   {ok, Bin} = do_recv(Sock, []),
#   ok = gen_tcp:close(Sock),
#   ok = gen_tcp:close(LSock),
#   Bin.

defmodule Server.Port do
  def client() do
    some_host_in_net = 'localhost'
    {:ok, sock} = :gen_tcp.connect(some_host_in_net, 5678, [:binary, {:packet, 0}])
    :ok = :gen_tcp.send(sock, "some_data")
    :ok = :gen_tcp.close(sock)
  end

  def server() do
    {:ok, lsock} = :gen_tcp.listen(5678, [:binary, packet: 0, active: false])
    {:ok, sock} = :gen_tcp.accept(lsock)
    {:ok, bin} = :gen_tcp.recv(sock, 0)
    # handles
    :ok = :gen_tcp.close(sock)
    :ok = :gen_tcp.close(lsock)
    bin
  end
end
