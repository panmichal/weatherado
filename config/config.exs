# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :weatherado,
  ecto_repos: [Weatherado.Repo]

# Configures the endpoint
config :weatherado, WeatheradoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KFXWhsx509XaSY2Yyxt8xACzczQ3P1Qboo2SAgtm82b6gnUrgwCFoOE8HLKQkcHo",
  render_errors: [view: WeatheradoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Weatherado.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
