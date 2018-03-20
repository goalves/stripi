defmodule Stripex.CustomersTest do
  use Stripex.ApiCase
  alias Stripex.Customer

  test "create should create customer" do
    {atom, response} = Customer.create(%{email: "example@example.com"})

    assert atom == :ok
    assert response.status == 200
    assert response.body["email"] == "example@example.com"
  end

  test "retrieve should get customer" do
    {:ok, response} = Customer.create(%{email: "example@example.com"})
    {atom, response} = Customer.fetch(response.body["id"])

    assert atom == :ok
    assert response.status == 200
    assert response.body["email"] == "example@example.com"
  end

  test "remove should delete customer" do
    {:ok, create_response} = Customer.create(%{email: "example@example.com"})
    {atom, response} = Customer.remove(create_response.body["id"])

    assert atom == :ok
    assert response.status == 200
    assert response.body["deleted"] == true

    {retrieve_atom, retrieve_response} = Customer.fetch(create_response.body["id"])
    assert retrieve_atom == :ok
    assert retrieve_response.status == 200
    assert retrieve_response.body["deleted"] == true
  end

  test "update should update customer" do
    {:ok, create_response} =
      Customer.create(%{email: "example@example.com", description: "created"})

    {atom, response} = Customer.update(create_response.body["id"], %{description: "updated"})

    assert atom == :ok
    assert response.status == 200
    assert response.body["description"] == "updated"
  end

  test "index should list all customers" do
    {:ok, _} = Customer.create(%{email: "example1@example.com"})
    {:ok, _} = Customer.create(%{email: "example2@example.com"})
    {atom, response} = Customer.index()

    assert atom == :ok
    assert response.status == 200
  end
end
