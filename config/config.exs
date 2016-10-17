# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :baseflow,
  ecto_repos: []

# Configures the endpoint
config :baseflow, Baseflow.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LXrWFDG7e0UPNr3MUKGxJjLvvd47WRvTBYegmezRi2jUjBMPddnuyY21g3EnST4X",
  render_errors: [view: Baseflow.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Baseflow.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
