defmodule Stripi.Api do
  defmacro __using__(_) do
    quote do
      use Tesla, except: ~w(head options)a

      plug(
        Tesla.Middleware.FormUrlencoded,
        encode: &Plug.Conn.Query.encode/1,
        decode: &Plug.Conn.Query.decode/1
      )

      plug(Tesla.Middleware.Headers, Stripi.headers())
      plug(Tesla.Middleware.JSON)

      import Stripi.Api
    end
  end

  def api_version(), do: "2019-02-19"
end
