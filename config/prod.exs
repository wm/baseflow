use Mix.Config

config :baseflow, Baseflow.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "floating-thicket-16453.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :logger, level: :info
