defmodule MyList do
  def caeser([], _) do
    []
  end
  def caeser([head | tail], n) when head + n > ?z do
    [?a + ((head + n) - ?z - 1) | caeser(tail, n)]
  end

  def caeser([head | tail], n) when head + n <= 122 do
    [head + n | caeser(tail, n)]
  end
end
