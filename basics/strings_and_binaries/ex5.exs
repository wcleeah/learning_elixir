defmodule MyString do
  def center(strs) do
    max_len = longest(strs, -1)
    print(strs, max_len)
  end

  def longest([], len) do
    len
  end

  def longest([head | tail], len) do
    if String.length(head) > len do
      longest(tail, String.length(head))
    else
      longest(tail, len)
    end
  end

  def print([], _) do
  end

  def print([head | tail], len) do
    s_len = String.length(head)
    if s_len == len do
      IO.puts head
    else
      lp_len = div(len - s_len, 2) + s_len
      temp = String.pad_leading(head, lp_len, " ")
      IO.puts String.pad_trailing(temp, len - String.length(temp), " ")
    end
    print(tail, len)
  end
end
