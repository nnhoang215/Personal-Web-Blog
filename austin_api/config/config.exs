# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :austin_api,
  ecto_repos: [AustinApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :austin_api, AustinApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: AustinApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: AustinApi.PubSub,
  live_view: [signing_salt: "XL/aNX7C"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
  
# Configure Guardian
config :austin_api, AustinApiWeb.Auth.Guardian,
  issuer: "austin_api",
  secret_key: "hSLPQW+noiDXr2HGWxHha+TUJXzXwkYXXO/abMx8HXWDQBC7pVXtnxCDjuP6JGWz"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: AustinApi.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60 # how much time b4 the token gets swept

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
