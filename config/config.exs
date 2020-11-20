import Config

config :app,
  cluster_strategy: :gossip

import_config "#{config_env()}.exs"
