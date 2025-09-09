defmodule MyList do
  def max([head | tail]) do
    m(head, tail)
  end
  def m(local_max, [head | tail]) when local_max >= head do
    m(local_max, tail)
  end
  def m(local_max, [head | tail]) when local_max < head do
    m(head, tail)
  end
  def m(local_max, []) do
    local_max
  end
end
