defmodule Remote do
  def hello(n \\ 0) do
    receive do
      :status -> IO.inspect("Calls: #{n}")
      msg -> IO.inspect(msg)
    end

    hello(n + 1)
  end
end
