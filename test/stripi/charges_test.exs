defmodule Stripi.ChargesTest do
  use ExUnit.Case, async: true
  alias Stripi.{Customers, Charges}

  setup do
    {_, resp} =
      Customers.create(%{email: "charge_test_customers@example.com", source: "tok_mastercard"})

    %{customer_id: resp["id"]}
  end

  test "create should create a charge", %{customer_id: id} do
    {atom, response} = Charges.create(%{amount: 100, currency: "usd", customer: id})

    assert atom == :ok
    assert String.starts_with?(response["id"], "ch_")
    assert response["amount"] == 100
    assert response["currency"] == "usd"
  end

  test "retrieve should retrieve a charge", %{customer_id: id} do
    {:ok, create_resp} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {atom, response} = Charges.retrieve(create_resp["id"])

    assert atom == :ok
    assert String.starts_with?(response["id"], "ch_")
    assert response["amount"] == 100
    assert response["currency"] == "usd"
  end

  test "update should update a charge parameters", %{customer_id: id} do
    {:ok, create_resp} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {atom, response} = Charges.update(create_resp["id"], %{description: "some_description"})

    assert atom == :ok
    assert String.starts_with?(response["id"], "ch_")
    assert response["amount"] == 100
    assert response["currency"] == "usd"
    assert response["description"] == "some_description"
  end

  test "capture should capture a charge", %{customer_id: id} do
    {:ok, create_resp} =
      Charges.create(%{amount: 100, currency: "usd", customer: id, capture: false})

    {atom, response} = Charges.capture(create_resp["id"], %{amount: 100})

    assert atom == :ok
    assert String.starts_with?(response["id"], "ch_")
    assert response["captured"] == true
  end

  test "list should list all charges", %{customer_id: id} do
    {:ok, _} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {:ok, _} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {atom, response} = Charges.list()

    assert atom == :ok
    assert Enum.count(response["data"]) >= 2
  end

  test "list should list last two charges", %{customer_id: id} do
    {:ok, _} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {:ok, _} = Charges.create(%{amount: 100, currency: "usd", customer: id})
    {atom, response} = Charges.list("limit=2")

    assert atom == :ok
    assert Enum.count(response["data"]) == 2
  end
end
