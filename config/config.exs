use Mix.Config

config :stripi, base_url: "https://api.stripe.com/v1"
config :tesla, adapter: Tesla.Adapter.Hackney

if File.exists?("config/test_secret.exs"), do: import_config("test_secret.exs")
