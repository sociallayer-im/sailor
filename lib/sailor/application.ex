defmodule Sailor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SailorWeb.Telemetry,
      Sailor.Repo,
      {DNSCluster, query: Application.get_env(:sailor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Sailor.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Sailor.Finch},
      # Start a worker by calling: Sailor.Worker.start_link(arg)
      # {Sailor.Worker, arg},
      # Start to serve requests, typically the last entry
      SailorWeb.Endpoint,
      TwMerge.Cache
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sailor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SailorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
