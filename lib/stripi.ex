defmodule Stripi do
  @version Stripi.MixProject.project()[:version]

  @moduledoc """
  Stripi is yet another Stripe Api written in elixir.
  """
  def request(request_function, parameters) do
    request_function
    |> :erlang.apply(parameters)
    |> response()
  end

  defp response({:ok, resp = %{status: status}}) when status in 200..299, do: {:ok, resp.body}
  defp response({:ok, resp}), do: {:error, resp.body["error"]["type"]}
  defp response(error), do: error

  def secret_key() do
    :stripi
    |> Application.get_env(:secret_key)
    |> case do
      nil -> raise("Please ensure :stripi key in config has a :secret_key.")
      "sk_test_" <> _key = key -> key
      _ -> raise("Please ensure :stripi key in config is a test secret key.")
    end
  end

  def headers() do
    [
      {"Authorization", "Bearer #{Stripi.secret_key()}"},
      {"User-Agent", "Elixir Stripi v#{@version}"}
    ]
  end
end
