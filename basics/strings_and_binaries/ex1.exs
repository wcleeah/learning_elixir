defmodule MyString do
  def printable(char_list) do
    Enum.all?(char_list, fn ch -> ch in ? ..?~ end)
  end
end

