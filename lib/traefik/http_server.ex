defmodule Traefik.HttpServer do
  def start(port \\ 1024) when is_integer(port) and port > 1023 do
    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])

    IO.puts("🎧 Listen on #{port}...")
    accept_loop(listen_socket)
  end

  def accept_loop(listen_socket) do
    IO.puts("👱 🏽Waits for a client connection...")
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    IO.puts("👫 Client connected ...")
    spawn(fn -> serve(socket) end)
    accept_loop(listen_socket)
  end

  def serve(client_socket) do
    client_socket
    |> read()
    |> Traefik.Handler.handle()
    |> write_response(client_socket)
  end

  def read(client_socket) do
    {:ok, request} = :gen_tcp.recv(client_socket, 0)
    IO.puts("⬅️  Receive the request")
    IO.inspect(request, label: "📧 Request")
    request
  end

  def handles(_request) do
    # transform request into response
    """
      HTTP/1.1 200 OK
      Host: some.com
      User-Agent: telnet
      Content-Type: text/html
      Content-Lenght: 14
      Accept: */*

      Hello World!!!
    """
  end

  def write_response(response, client_socket) do
    :ok = :gen_tcp.send(client_socket, response)
    IO.puts("➡️  Response sent...")

    :ok = :gen_tcp.close(client_socket)
  end
end
