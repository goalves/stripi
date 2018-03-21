defmodule Stripi.Customers do
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/customers"
  use Stripi, :api

  def create(params, opts \\ []), do: Stripi.request(&post/3, [@url, params, opts])

  def retrieve(id, opts \\ []), do: Stripi.request(&get/2, [@url <> "/#{id}", opts])

  def remove(id, opts \\ []), do: Stripi.request(&delete/2, [@url <> "/#{id}", opts])

  def update(id, params, opts \\ []),
    do: Stripi.request(&post/3, [@url <> "/#{id}", params, opts])

  def list(opts \\ []), do: Stripi.request(&get/2, [@url, opts])
end
