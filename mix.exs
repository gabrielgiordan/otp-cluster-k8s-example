defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {App, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.4.1"},
      {:jason, "~> 1.2"},
      {:libcluster, "~> 3.2.1"},
      {:horde, "~> 0.8.3"}
    ]
  end
end
