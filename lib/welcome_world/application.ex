defmodule WelcomeWorld.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WelcomeWorldWeb.Telemetry,
      WelcomeWorld.Repo,
      {DNSCluster, query: Application.get_env(:welcome_world, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WelcomeWorld.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WelcomeWorld.Finch},
      # Start a worker by calling: WelcomeWorld.Worker.start_link(arg)
      # {WelcomeWorld.Worker, arg},
      # Start to serve requests, typically the last entry
      WelcomeWorldWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WelcomeWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WelcomeWorldWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
