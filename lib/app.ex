defmodule App do
  @moduledoc false

  use Application

  def start(_type, _args) do
    cluster_strategy = Application.fetch_env!(:app, :cluster_strategy)
    port = Application.fetch_env!(:app, :port)

    children = [
      {Cluster.Supervisor, [topologies(cluster_strategy), [name: App.ClusterSupervisor]]},
      {Plug.Cowboy, [scheme: :http, plug: App.Router, port: port]}
    ]

    Supervisor.start_link(
      children,
      strategy: :one_for_one,
      name: App.Supervisor
    )
  end

  defp topologies(:k8s) do
    [
      app: [
        strategy: Cluster.Strategy.Kubernetes.DNS,
        config: [
          service: "app-epmd",
          application_name: "app"
        ]
      ]
    ]
  end

  defp topologies(:gossip) do
    [
      app: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]
  end
end
