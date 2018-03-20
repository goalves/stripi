defmodule Stripi.MixProject do
  use Mix.Project

  def project(),
    do: [
      app: :stripi,
      version: "0.0.2",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/goalves/stripi",
      name: "Stripi",
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

  defp description(), do: "Stripi is yet another Stripe Elixir API."

  defp package(),
    do: [
      maintainers: ["Gabriel Alves"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/goalves/stripi"}
    ]

  def application(),
    do: [
      extra_applications: [:logger]
    ]

  defp deps(),
    do: [
      {:tesla, "~> 0.10.0"},
      {:poison, ">= 0.0.0"},
      {:excoveralls, "~> 0.8", only: :test},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
end
