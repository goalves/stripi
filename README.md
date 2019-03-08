# Stripi

Stripi is yet another Stripe Elixir API.

- [x] Charges
- [x] Customers
- [x] Ephemeral Keys
- [ ] Balance
- [ ] Disputes
- [ ] Events
- [ ] File Uploads
- [ ] Payouts
- [ ] Refunds
- [ ] Tokens
- [ ] Sources
- [ ] Subscriptions
- [ ] Connect

## Installation

The package can be installed by adding `Stripi` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stripi, "~> 0.2.0"}
  ]
end
```

## Running Tests

Since Stripe API requires you to use your own keys to test against it, you would need to create a "secret.exs" file in
the config folder for this project and add the following:

```elixir
use Mix.Config

config :stripi,
  base_url: "https://api.stripe.com/v1",
  secret_key: "sk_test_SECRET"
```
