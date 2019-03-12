defmodule Stripi.EphemeralKeys do
  use Stripi.Api
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/ephemeral_keys"

  def create(customer_id, opts \\ [headers: [{"Stripe-Version", api_version()}]]),
    do: Stripi.request(&post/3, [@url, %{customer: customer_id}, opts])

  def remove(key, opts \\ []), do: Stripi.request(&delete/2, [@url <> "/#{key}", opts])
end
