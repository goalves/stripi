# Stripi

[![CircleCI](https://circleci.com/gh/goalves/stripi.svg?style=svg)](https://circleci.com/gh/goalves/stripi)
[![Coverage Status](https://coveralls.io/repos/github/goalves/stripi/badge.svg?branch=master)](https://coveralls.io/github/goalves/stripi?branch=master)

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
- [X] Sources (part of it)
- [ ] Subscriptions
- [ ] Connect

## Installation

The package can be installed by adding `Stripi` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stripi, "~> 0.1.0"}
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

## Usage

Tests are the best documentation of any code, the easiest way to understand how to use the library is by reading the
test cases.
