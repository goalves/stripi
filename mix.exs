defmodule Stripex.MixProject do
  use Mix.Project

  def project(),
    do: [
      app: :stripex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application(),
    do: [
      extra_applications: [:logger]
    ]

  defp deps(),
    do: [
      {:tesla, "~> 0.10.0"},
      {:poison, ">= 0.0.0"},
      {:excoveralls, "~> 0.8", only: :test},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}
    ]
end
