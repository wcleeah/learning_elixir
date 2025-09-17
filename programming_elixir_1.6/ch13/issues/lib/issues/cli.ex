defmodule Issues.CLI do
  @default_count 4

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def parse_args(argv) do
    OptionParser.parse(argv, [switches: [help: :boolean], aliases: [h: :help]])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([ user, project, count ]) do
     { user, project, String.to_integer(count) }
  end

  def args_to_internal_representation([ user, project ]) do
     { user, project, @default_count }
  end

  def args_to_internal_representation(_) do
    :help
  end

  def process(:help) do
    IO.puts "No Help For You Loser"
    System.halt(0)
  end

  def process({ user, project, count }) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_descending_order()
    |> last(count)
    |> Issues.Format.format_and_print()
  end

  def sort_into_descending_order(issues) do
    issues
    |> Enum.sort(&(&1["created_at"] >= &2["created_at"]))
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end

  def decode_response({ :ok, body }) do
    body
  end

  def decode_response({ :error, error }) do
    IO.puts "Github sucks! #{error["message"]}"
    System.halt(2)
  end

end
