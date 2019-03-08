use Mix.Config

config :stripi, base_url: "https://api.stripe.com/v1"
config :tesla, adapter: Tesla.Adapter.Hackney

if File.exists?("config/secret.exs"), do: import_config("secret.exs")
