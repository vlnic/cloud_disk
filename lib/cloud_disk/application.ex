defmodule CloudDisk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CloudDisk.Repo,
      # Start the Telemetry supervisor
      CloudDiskWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CloudDisk.PubSub},
      # Start the Endpoint (http/https)
      CloudDiskWeb.Endpoint
      # Start a worker by calling: CloudDisk.Worker.start_link(arg)
      # {CloudDisk.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CloudDisk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CloudDiskWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
