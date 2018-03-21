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

  def api do
    quote do
      use Tesla, except: ~w(head options)a

      plug(Tesla.Middleware.Tuples)
      plug(Tesla.Middleware.FormUrlencoded)
      plug(Tesla.Middleware.Headers, Stripi.headers())
      plug(Tesla.Middleware.DecodeJson)
    end
  end

  def secret_key() do
    :stripi
    |> Application.get_env(:secret_key)
    |> case do
      nil -> raise("Please ensure :stripi key in config has a :secret_key.")
      key -> key
    end
  end

  def headers() do
    %{
      "Authorization" => "Bearer #{Stripi.secret_key()}",
      "User-Agent" => "Stripi v#{@version}",
      "Content-Type" => "application/x-www-form-urlencoded"
    }
  end

  def api_version(), do: "2018-02-28"

  defmacro __using__(which) when is_atom(which), do: apply(__MODULE__, which, [])
end
