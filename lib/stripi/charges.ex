defmodule Stripi.Charges do
  @url Application.get_env(:stripi, :base_url, "https://api.stripe.com/v1") <> "/charges"
  use Stripi, :api

  def create(params, opts \\ []), do: Stripi.request(&post/3, [@url, params, opts])

  def retrieve(id, opts \\ []), do: Stripi.request(&get/2, [@url <> "/#{id}", opts])

  def update(id, params, opts \\ []),
    do: Stripi.request(&post/3, [@url <> "/#{id}", params, opts])

  def capture(id, params \\ %{}, opts \\ []),
    do: Stripi.request(&post/3, [@url <> "/#{id}/capture", params, opts])

  def list(query \\ "", opts \\ []), do: Stripi.request(&get/2, [@url <> "?" <> query, opts])
end
