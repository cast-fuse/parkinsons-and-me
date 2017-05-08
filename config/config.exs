# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :parkinsons_and_me,
  ecto_repos: [ParkinsonsAndMe.Repo]

# Configures the endpoint
config :parkinsons_and_me, ParkinsonsAndMe.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5N65cDOd77huncT/QV/+pZh6NH2RDJYqujaTTi4IeIHLvLIn6e6wxYFqFgzGAbAR",
  render_errors: [view: ParkinsonsAndMe.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ParkinsonsAndMe.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config for email service
config :parkinsons_and_me, ParkinsonsAndMe.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: System.get_env("MAILGUN_KEY"),
  domain: System.get_env("MAILGUN_DOMAIN")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
