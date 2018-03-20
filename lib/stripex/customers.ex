defmodule Stripi.Customer do
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/customers"
  use Stripi, :api

  def create(params), do: Stripi.request(&post/2, [@url, params])
  def fetch(id), do: Stripi.request(&get/2, [@url <> "/#{id}", []])
  def remove(id), do: Stripi.request(&delete/2, [@url <> "/#{id}", []])
  def update(id, params), do: Stripi.request(&post/2, [@url <> "/#{id}", params])
  def index(params \\ []), do: Stripi.request(&get/2, [@url, params])
end
