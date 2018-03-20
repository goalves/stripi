use Mix.Config

config :stripex, base_url: "https://api.stripe.com/v1"

if File.exists?("config/secret.exs") do
  import_config "secret.exs"
end
