defmodule Stripi.EphemeralKeysTest do
  use Stripi.ApiCase
  alias Stripi.Customer
  alias Stripi.EphemeralKeys

  test "create should create a ephemeral key for a customer" do
    {:ok, create_response} = Customer.create(%{email: "example@example.com"})
    {atom, response} = EphemeralKeys.create(create_response["id"])

    assert atom == :ok
    assert String.starts_with?(response["id"], "ephkey_")
  end

  test "remove should delete a ephemeral key for a customer" do
    {:ok, customer_create_response} = Customer.create(%{email: "example@example.com"})
    {:ok, ephemeral_create_response} = EphemeralKeys.create(customer_create_response["id"])

    {atom, response} = EphemeralKeys.remove(ephemeral_create_response["id"])

    assert atom == :ok
    assert String.starts_with?(response["id"], "ephkey_")
  end
end
