defmodule Remote do
  def hello do
    receive do
      msg -> IO.inspect(msg)
    end

    hello()
  end
end
