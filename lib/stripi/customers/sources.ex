defmodule Stripi.Customers.Sources do
  use Stripi.Api

  @base_url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/customers"
  @resource_url "/sources"
  @cards_query "object=card"

  def create(customer_id, params, opts \\ []), do: Stripi.request(&post/3, [build_url(customer_id), params, opts])

  def retrieve(customer_id, id, opts \\ []), do: Stripi.request(&get/2, [build_url(customer_id) <> "/#{id}", opts])

  def remove(customer_id, id, opts \\ []), do: Stripi.request(&delete/2, [build_url(customer_id) <> "/#{id}", opts])

  def update(customer_id, id, params, opts \\ []),
    do: Stripi.request(&post/3, [build_url(customer_id) <> "/#{id}", params, opts])

  def list_cards(customer_id, query \\ "", opts \\ []),
    do: Stripi.request(&get/2, [build_url(customer_id) <> "?" <> @cards_query <> query, opts])

  defp build_url(customer_id) when is_bitstring(customer_id),
    do: @base_url <> "/" <> customer_id <> @resource_url
end
