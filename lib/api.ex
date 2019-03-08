defmodule Stripi.Api do
  defmacro __using__(_) do
    quote do
      use Tesla, except: ~w(head options)a

      plug(Tesla.Middleware.FormUrlencoded)
      plug(Tesla.Middleware.Headers, Stripi.headers())
      plug(Tesla.Middleware.JSON)

      import Stripi.Api
    end
  end

  def api_version(), do: "2018-02-28"
end
