import Config

config :app,
  port: System.get_env("PORT", "4000") |> String.to_integer()
