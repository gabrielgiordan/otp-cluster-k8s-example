defmodule App do
  @moduledoc false

  alias __MODULE__.Index

  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [cluster_k8s(), [name: App.ClusterSupervisor]]},
      cowboy_supervisor()
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

  defp cowboy_supervisor() do
    %{
      id: :cowboy_supervisor,
      start: {
        :cowboy,
        :start_clear,
        [
          :cowboy_supervisor,
          %{socket_opts: [port: port()]},
          %{env: %{dispatch: cowboy_dispatch()}}
        ]
      },
      restart: :permanent,
      shutdown: :infinity,
      type: :supervisor
    }
  end

  defp cowboy_dispatch() do
    :cowboy_router.compile([
      {
        :_,
        [
          {:_, Index, %{}}
        ]
      }
    ])
  end

  defp port() do
    String.to_integer(System.get_env("PORT", "4000"))
  end
end
