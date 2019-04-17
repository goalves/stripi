defmodule Stripi.Customers.SourcesTest do
  use ExUnit.Case, async: false
  alias Stripi.Customers
  alias Stripi.Customers.Sources

  @valid_credit_card_data %{source: "tok_amex"}

  setup do
    {:ok, customer} = Customers.create(%{email: "example@example.com"})
    %{customer_id: customer["id"]}
  end

  test "should create a source", %{customer_id: customer_id} do
    assert {:ok, source} = Sources.create(customer_id, @valid_credit_card_data)
    assert source["object"] == "card"
  end

  test("should fail to create a source when data is invalid", %{customer_id: customer_id},
    do: assert({:error, "invalid_request_error"} = Sources.create(customer_id, %{}))
  )

  test "retrieve/2 should get source", %{customer_id: customer_id} do
    {:ok, created_source} = Sources.create(customer_id, @valid_credit_card_data)
    assert {:ok, response} = Sources.retrieve(customer_id, created_source["id"])
  end

  test "remove/2 should delete source", %{customer_id: customer_id} do
    {:ok, created_source} = Sources.create(customer_id, @valid_credit_card_data)
    assert {:ok, %{"deleted" => true}} = Sources.remove(customer_id, created_source["id"])
  end

  test "update/2 should update source", %{customer_id: customer_id} do
    {:ok, created_source} = Sources.create(customer_id, @valid_credit_card_data)

    assert {:ok, updated_source} = Sources.update(customer_id, created_source["id"], %{name: "updated_name"})
    assert updated_source["name"] == "updated_name"
  end

  test "list_cards/3 should list all customers", %{customer_id: customer_id} do
    {:ok, %{"id" => first_id}} = Sources.create(customer_id, @valid_credit_card_data)
    {:ok, %{"id" => second_id}} = Sources.create(customer_id, @valid_credit_card_data)
    assert {:ok, response} = Sources.list_cards(customer_id)
    assert first_id in Enum.map(response["data"], & &1["id"])
    assert second_id in Enum.map(response["data"], & &1["id"])
  end
end
