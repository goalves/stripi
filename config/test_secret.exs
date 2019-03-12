use Mix.Config

config :stripi, secret_key: System.get_env("STRIPE_SECRET")
