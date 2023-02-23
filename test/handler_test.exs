defmodule Traefik.HandlerTest do
  use ExUnit.Case

  alias Traefik.Handler

  test "GET /hello" do
    request = """
    GET /hello HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    User-Agent: telnet\r
    \r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 14
           Accept: */*

           Hello World!!!
           """
  end

  test "GET /world" do
    request = """
    GET /world HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    User-Agent: telnet\r
    \r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 29
           Accept: */*

           Hello MakingDevs and all devs
           """
  end

  test "GET /not-found" do
    request = """
    GET /not-found HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    User-Agent: telnet\r
    \r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 404 Not Found
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 22
           Accept: */*

           No /not-found found!!!
           """
  end

  test "GET /redirectme" do
    request = """
    GET /redirectme HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    User-Agent: telnet\r
    \r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 404 Not Found
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 16
           Accept: */*

           No /all found!!!
           """
  end

  test "GET /about" do
    request = """
    GET /about HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    User-Agent: telnet\r
    \r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 139
           Accept: */*

           <h1>Hola mundo!</h1>
           <p>
           <blockquote>Hola Mundo developers</blockquote>
           <ul>
           <li>MakingDevs</li>
           <li>Agora</li>
           <li>Legion</li>
           </ul>
           </p>

           """
  end

  test "POST /new" do
    request = """
    POST /new HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    Content-Type: application/x-www-form-urlencoded\r
    User-Agent: telnet\r
    \r
    name=Juan&company=MakingDevs
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 201 Created
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 44
           Accept: */*

           A new element created: Juan from MakingDevs

           """
  end

  test "GET /developer" do
    request = """
    GET /developer HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    Content-Type: application/x-www-form-urlencoded\r
    User-Agent: telnet\r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 159
           Accept: */*

           <ul>

           <li>1 - Jerri Rubertis</li>

           <li>2 - Lief Gepson</li>

           <li>3 - Viki Van Halle</li>

           <li>4 - Maribelle Dubose</li>

           <li>5 - Vivian Klarzynski</li>

           </ul>

           """
  end

  test "GET /developer/18" do
    request = """
    GET /developer/17 HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    Content-Type: application/x-www-form-urlencoded\r
    User-Agent: telnet\r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 53
           Accept: */*

           17 - Slade - Sams - ssamsg@ucoz.com - 157.180.106.51

           """
  end

  test "GET /api/developer" do
    request = """
    GET /api/developer HTTP/1.1\r
    Accept: */*\r
    Connection: keep-alive\r
    User-Agent: telnet\r
    \r
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: application/json
           Content-Lenght: 1326
           Accept: */*

           [{\"email\":\"jrubertis0@nytimes.com\",\"first_name\":\"Jerri\",\"gender\":\"Male\",\"id\":1,\"ip_address\":\"206.67.100.126\",\"last_name\":\"Rubertis\"},{\"email\":\"lgepson1@amazon.com\",\"first_name\":\"Lief\",\"gender\":\"Male\",\"id\":2,\"ip_address\":\"235.91.3.49\",\"last_name\":\"Gepson\"},{\"email\":\"vvanhalle2@quantcast.com\",\"first_name\":\"Viki\",\"gender\":\"Female\",\"id\":3,\"ip_address\":\"53.76.94.126\",\"last_name\":\"Van Halle\"},{\"email\":\"mdubose3@ftc.gov\",\"first_name\":\"Maribelle\",\"gender\":\"Female\",\"id\":4,\"ip_address\":\"107.46.58.239\",\"last_name\":\"Dubose\"},{\"email\":\"vklarzynski4@mtv.com\",\"first_name\":\"Vivian\",\"gender\":\"Agender\",\"id\":5,\"ip_address\":\"7.247.165.222\",\"last_name\":\"Klarzynski\"},{\"email\":\"hbedome5@slashdot.org\",\"first_name\":\"Helyn\",\"gender\":\"Genderqueer\",\"id\":6,\"ip_address\":\"24.241.90.151\",\"last_name\":\"Bedome\"},{\"email\":\"lsidney6@technorati.com\",\"first_name\":\"Lyndsay\",\"gender\":\"Female\",\"id\":7,\"ip_address\":\"54.172.132.20\",\"last_name\":\"Sidney\"},{\"email\":\"epoluzzi7@exblog.jp\",\"first_name\":\"Emmye\",\"gender\":\"Female\",\"id\":8,\"ip_address\":\"83.213.206.127\",\"last_name\":\"Poluzzi\"},{\"email\":\"bfitzsymons8@pen.io\",\"first_name\":\"Barn\",\"gender\":\"Male\",\"id\":9,\"ip_address\":\"117.249.1.245\",\"last_name\":\"Fitzsymons\"},{\"email\":\"amuggleston9@livejournal.com\",\"first_name\":\"Adelheid\",\"gender\":\"Female\",\"id\":10,\"ip_address\":\"91.155.84.10\",\"last_name\":\"Muggleston\"}]
           """
  end
end
