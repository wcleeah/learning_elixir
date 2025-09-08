defmodule Chop do
  def guess(ans, range) do
    mid = div(range.last - range.first, 2) + 1
    pg(ans, range, mid)
  end
  def pg(ans, _, guess) when guess == ans do
    IO.puts "Is it #{guess}"
    IO.puts ans
  end
  def pg(ans, range, guess) when guess > ans do
    IO.puts "Is it #{guess}"
    mid = div(guess - range.first, 2) + range.first
    pg(ans, range.first..guess, mid)
  end
  def pg(ans, range, guess) when guess < ans do
    IO.puts "Is it #{guess}"
    mid = guess + div(range.last - guess, 2)
    pg(ans, guess..range.last, mid)
  end
end
