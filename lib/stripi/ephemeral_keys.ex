defmodule Stripi.EphemeralKeys do
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/ephemeral_keys"
  use Stripi, :api

  def create(customer_id, opts \\ [headers: [{"Stripe-Version", Stripi.api_version()}]]),
    do: Stripi.request(&post/3, [@url, %{customer: customer_id}, opts])

  def remove(key, opts \\ []), do: Stripi.request(&delete/2, [@url <> "/#{key}", opts])
end
