defmodule Stripex.Customer do
  @url Application.get_env(:stripex, :base_url) <> "/customers"
  use Stripex, :api

  def create(params), do: Stripex.request(&post/2, [@url, params])
  def fetch(id), do: Stripex.request(&get/2, [@url <> "/#{id}", []])
  def remove(id), do: Stripex.request(&delete/2, [@url <> "/#{id}", []])
  def update(id, params), do: Stripex.request(&post/2, [@url <> "/#{id}", params])
  def index(params \\ []), do: Stripex.request(&get/2, [@url, params])
end
