defmodule Recursive do
  def factorial(0, r), do: r

  def factorial(n, r) do
    IO.inspect(binding())
    factorial(n - 1, r * n)
  end
end

IO.inspect("Factorial of 5: #{Recursive.factorial(5, 1)}")
IO.puts("###################")
IO.inspect("Factorial of 15: #{Recursive.factorial(15, 1)}")
IO.puts("###################")
IO.inspect("Factorial of 45: #{Recursive.factorial(45, 1)}")
