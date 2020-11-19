defmodule App do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [cluster_k8s(), [name: App.ClusterSupervisor]]},
      {Plug.Cowboy, [scheme: :http, plug: App.Router, port: port()]}
    ]

    Supervisor.start_link(
      children,
      strategy: :one_for_one,
      name: App.Supervisor
    )
  end

  defp cluster_k8s() do
    [
      app: [
        strategy: Cluster.Strategy.Kubernetes.DNS,
        config: [
          service: "app-nodes",
          application_name: "app"
        ]
      ]
    ]
  end

  defp cluster_gossip() do
    [
      app: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]
  end

  defp port() do
    String.to_integer(System.get_env("PORT", "4000"))
  end
end
