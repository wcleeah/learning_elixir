defmodule Issues.Format do
  def format_and_print(list) do
    print_header()
    print_data(list)
  end

  def print_header() do
    IO.puts "*  | created_at           | title "          
  end

  def print_data([]) do
  end

  def print_data([head | tail]) do
    IO.puts "#{head["number"]} | #{head["created_at"]} | #{head["title"]}"
    print_data(tail)
  end
end
