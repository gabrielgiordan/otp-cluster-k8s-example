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
      {:cowboy, "~> 2.8"},
      {:libcluster, "~> 3.2.1"}
    ]
  end
end
