defmodule Stripi.EphemeralKeys do
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/ephemeral_keys"
  use Stripi, :api

  def create(customer_id), do: Stripi.request(&post/2, [@url, %{customer: customer_id}])

  def remove(key), do: Stripi.request(&delete/1, [@url <> "/#{key}"])
end
