defmodule MyList do
  def span(from, to) when from == to do
    [to]
  end
  def span(from, to) do 
    [from | span(from+1, to)]
  end
end
