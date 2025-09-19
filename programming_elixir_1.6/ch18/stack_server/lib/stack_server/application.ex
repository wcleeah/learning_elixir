defmodule StackServer.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Note: Server heavily depends on Stash, and it just assumes Stash is always alive
      {StackServer.Stash, [1,2,3]},
      {StackServer.Server, []}
    ]

    # The book suggest using rest_for_one, i strongly disagree
    # I seriously don't know a scenerio that we should bring down a server if the cache server is down
    opts = [strategy: :one_for_one, name: StackServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
