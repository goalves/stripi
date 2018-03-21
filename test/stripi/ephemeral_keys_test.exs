defmodule Stripi.EphemeralKeysTest do
  use ExUnit.Case, async: true
  alias Stripi.{Customers, EphemeralKeys}

  test "create should create a ephemeral key for a customer" do
    {:ok, create_response} = Customers.create(%{email: "example@example.com"})

    {atom, response} =
      EphemeralKeys.create(create_response["id"], headers: %{"Stripe-Version" => "2018-02-28"})

    assert atom == :ok
    assert String.starts_with?(response["id"], "ephkey_")
  end

  test "create should create a ephemeral key for a customer without passing headers" do
    {:ok, create_response} = Customers.create(%{email: "example@example.com"})

    {atom, response} = EphemeralKeys.create(create_response["id"])

    assert atom == :ok
    assert String.starts_with?(response["id"], "ephkey_")
  end

  test "remove should delete a ephemeral key for a customer" do
    {:ok, customer_create_response} = Customers.create(%{email: "example@example.com"})

    {:ok, ephemeral_create_response} =
      EphemeralKeys.create(
        customer_create_response["id"],
        headers: %{"Stripe-Version" => "2018-02-28"}
      )

    {atom, response} = EphemeralKeys.remove(ephemeral_create_response["id"])

    assert atom == :ok
    assert String.starts_with?(response["id"], "ephkey_")
  end
end
