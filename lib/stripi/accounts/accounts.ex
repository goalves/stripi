defmodule Stripi.Accounts do
  use Stripi.Api
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/accounts"

  def create(params, opts \\ []) do
    default_params = %{type: "custom", "requested_capabilities[]": "transfers"}
    account_params = Map.merge(default_params, params)
    Stripi.request(&post/3, [@url, account_params, opts])
  end

  def retrieve(id, opts \\ []), do: Stripi.request(&get/2, [@url <> "/#{id}", opts])

  def remove(id, opts \\ []), do: Stripi.request(&delete/2, [@url <> "/#{id}", opts])

  def update(id, params, opts \\ []),
    do: Stripi.request(&post/3, [@url <> "/#{id}", params, opts])

  def list(query \\ "", opts \\ []), do: Stripi.request(&get/2, [@url <> "?" <> query, opts])

  def reject(id, params, opts \\ []) do
    Stripi.request(&post/3, [@url <> "/#{id}/reject", params, opts])
  end
end
