defmodule Stripi.CustomersTest do
  use ExUnit.Case, async: true
  alias Stripi.Customers

  test "create should create customer" do
    {atom, response} = Customers.create(%{email: "example@example.com"})

    assert atom == :ok
    assert response["email"] == "example@example.com"
  end

  test "retrieve should get customer" do
    {:ok, response} = Customers.create(%{email: "example@example.com"})
    {atom, response} = Customers.retrieve(response["id"])

    assert atom == :ok
    assert response["email"] == "example@example.com"
  end

  test "remove should delete customer" do
    {:ok, create_response} = Customers.create(%{email: "example@example.com"})
    {atom, response} = Customers.remove(create_response["id"])

    assert atom == :ok
    assert response["deleted"] == true

    {retrieve_atom, retrieve_response} = Customers.retrieve(create_response["id"])
    assert retrieve_atom == :ok
    assert retrieve_response["deleted"] == true
  end

  test "update should update customer" do
    {:ok, create_response} =
      Customers.create(%{email: "example@example.com", description: "created"})

    {atom, response} = Customers.update(create_response["id"], %{description: "updated"})

    assert atom == :ok
    assert response["description"] == "updated"
  end

  test "index should list all customers" do
    {:ok, _} = Customers.create(%{email: "example1@example.com"})
    {:ok, _} = Customers.create(%{email: "example2@example.com"})
    {atom, response} = Customers.list()

    assert atom == :ok
    assert Enum.count(response["data"]) >= 2
  end
end
