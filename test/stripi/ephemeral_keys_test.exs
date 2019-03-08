defmodule Stripi.EphemeralKeysTest do
  use ExUnit.Case, async: false
  alias Stripi.{Customers, EphemeralKeys}

  setup do
    {:ok, created_customer} = Customers.create(%{email: "example@example.com"})
    %{customer_id: created_customer["id"]}
  end

  test "create should create a ephemeral key for a customer", %{customer_id: customer_id} do
    assert {:ok, response} = EphemeralKeys.create(customer_id, headers: [{"Stripe-Version", "2019-02-19"}])
    assert String.starts_with?(response["id"], "ephkey_")
  end

  test "create should create a ephemeral key for a customer without passing headers", %{customer_id: customer_id} do
    assert {:ok, response} = EphemeralKeys.create(customer_id)
    assert String.starts_with?(response["id"], "ephkey_")
  end

  test "remove should delete a ephemeral key for a customer", %{customer_id: customer_id} do
    assert {:ok, created_key} = EphemeralKeys.create(customer_id, headers: [{"Stripe-Version", "2019-02-19"}])
    assert {:ok, response} = EphemeralKeys.remove(created_key["id"])
    assert String.starts_with?(response["id"], "ephkey_")
  end
end
