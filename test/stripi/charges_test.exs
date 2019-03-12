defmodule Stripi.ChargesTest do
  use ExUnit.Case, async: false
  alias Stripi.{Customers, Charges}

  setup do
    {:ok, customer} = Customers.create(%{email: "charge_test_customers@example.com", source: "tok_mastercard"})
    %{customer_id: customer["id"]}
  end

  test "create should create a charge", %{customer_id: id} do
    assert {:ok, response} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    assert String.starts_with?(response["id"], "ch_")
    assert response["amount"] == 100
    assert response["currency"] == "usd"
  end

  test "retrieve should retrieve a charge", %{customer_id: id} do
    {:ok, create_resp} = Charges.create(%{amount: 100, currency: "usd", customer: id})

    assert {:ok, response} = Charges.retrieve(create_resp["id"])
    assert String.starts_with?(response["id"], "ch_")
    assert response["amount"] == 100
    assert response["currency"] == "usd"
  end

  test "update should update a charge parameters", %{customer_id: id} do
    {:ok, create_resp} = Charges.create(%{amount: 100, currency: "usd", customer: id})

    assert {:ok, response} = Charges.update(create_resp["id"], %{description: "some_description"})
    assert String.starts_with?(response["id"], "ch_")
    assert response["amount"] == 100
    assert response["currency"] == "usd"
    assert response["description"] == "some_description"
  end

  test "capture should capture a charge", %{customer_id: id} do
    {:ok, create_resp} = Charges.create(%{amount: 100, currency: "usd", customer: id, capture: false})

    assert {:ok, response} = Charges.capture(create_resp["id"], %{amount: 100})
    assert String.starts_with?(response["id"], "ch_")
    assert response["captured"] == true
  end

  test "list should list all charges", %{customer_id: id} do
    {:ok, _} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {:ok, _} = Charges.create(%{amount: 100, currency: "usd", customer: id})

    assert {:ok, response} = Charges.list()
    assert Enum.count(response["data"]) >= 2
  end

  test "list should list last two charges", %{customer_id: id} do
    first_amount = 100
    second_amount = 200
    {:ok, _} = Charges.create(%{amount: first_amount, currency: "usd", customer: id})
    {:ok, _} = Charges.create(%{amount: second_amount, currency: "usd", customer: id})

    assert {:ok, response} = Charges.list("limit=2")
    assert [first_charge, second_charge] = response["data"]
    assert first_charge["amount"] == second_amount
    assert second_charge["amount"] == first_amount
  end
end
