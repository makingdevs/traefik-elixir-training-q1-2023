defmodule Traefik.HandlerTest do
  use ExUnit.Case

  alias Traefik.Handler

  test "GET /hello" do
    request = """
    GET /hello HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet


    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "GET /world" do
    request = """
    GET /world HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet


    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "GET /not-found" do
    request = """
    GET /not-found HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet


    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "GET /redirectme" do
    request = """
    GET /redirectme HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet


    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "GET /about" do
    request = """
    GET /about HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet


    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "POST /new" do
    request = """
    POST /new HTTP/1.1
    Accept: */*
    Connection: keep-alive
    Content-Type: application/x-www-form-urlencoded
    User-Agent: telnet

    name=Juan&company=MakingDevs
    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "GET /developer" do
    request = """
    GET /developer HTTP/1.1
    Accept: */*
    Connection: keep-alive
    Content-Type: application/x-www-form-urlencoded
    User-Agent: telnet

    """

    response = Handler.handle(request)

    assert response == """
           """
  end

  test "GET /developer/18" do
    request = """
    GET /developer/17 HTTP/1.1
    Accept: */*
    Connection: keep-alive
    Content-Type: application/x-www-form-urlencoded
    User-Agent: telnet

    """

    response = Handler.handle(request)

    assert response == """
           """
  end
end
