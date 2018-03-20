defmodule Stripi.EphemeralKeysTest do
  use Stripi.ApiCase
  alias Stripi.Customer
  alias Stripi.EphemeralKeys

  test "create should create a ephemeral key for a customer" do
    {:ok, create_response} = Customer.create(%{email: "example@example.com"})
    {atom, response} = EphemeralKeys.create(create_response.body["id"])

    assert atom == :ok
    assert response.status == 200
  end

  test "remove should delete a ephemeral key for a customer" do
    {:ok, customer_create_response} = Customer.create(%{email: "example@example.com"})
    {:ok, ephemeral_create_response} = EphemeralKeys.create(customer_create_response.body["id"])

    {atom, response} = EphemeralKeys.remove(ephemeral_create_response.body["id"])

    assert atom == :ok
    assert response.status == 200
  end
end
