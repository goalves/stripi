defmodule Stripi.CustomersTest do
  use ExUnit.Case, async: false
  alias Stripi.Customers

  test "create should create customer" do
    assert {:ok, response} = Customers.create(%{email: "example@example.com"})
    assert response["email"] == "example@example.com"
  end

  test "create should return an error when email is invalid",
    do: assert({:error, "invalid_request_error"} = Customers.create(%{email: "example.example.com"}))

  test "retrieve should get customer" do
    {:ok, created_customer} = Customers.create(%{email: "example@example.com"})

    assert {:ok, response} = Customers.retrieve(created_customer["id"])
    assert response["email"] == "example@example.com"
  end

  test "remove should delete customer" do
    {:ok, created_customer} = Customers.create(%{email: "example@example.com"})

    assert {:ok, %{"deleted" => true}} = Customers.remove(created_customer["id"])
    assert {:ok, %{"deleted" => true}} = Customers.retrieve(created_customer["id"])
  end

  test "update should update customer" do
    {:ok, created_customer} = Customers.create(%{email: "example@example.com", description: "created"})

    assert {:ok, updated_customer} = Customers.update(created_customer["id"], %{description: "updated"})
    assert updated_customer["description"] == "updated"
  end

  test "index should list all customers" do
    {:ok, _} = Customers.create(%{email: "example1@example.com"})
    {:ok, _} = Customers.create(%{email: "example2@example.com"})
    assert {:ok, response} = Customers.list()
    assert Enum.count(response["data"]) >= 2
  end

  test "index should list last two customers" do
    first_email = "example1@example.com"
    second_email = "example2@example.com"
    {:ok, _} = Customers.create(%{email: first_email})
    {:ok, _} = Customers.create(%{email: second_email})

    assert {:ok, response} = Customers.list("limit=2")
    assert [first_customer, second_customer] = response["data"]
    assert first_customer["email"] == second_email
    assert second_customer["email"] == first_email
  end
end
