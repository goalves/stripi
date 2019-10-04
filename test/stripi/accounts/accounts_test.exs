defmodule Stripi.AccountsTest do
  use ExUnit.Case, async: false
  alias Stripi.Accounts

  describe "create/2" do
    test "should create an account" do
      assert {:ok, response} = Accounts.create(%{email: "example@example.com", country: "US"})

      assert response["object"] == "account"
      assert response["email"] == "example@example.com"
      assert response["country"] == "US"
    end

    test "should create an account with the requested capabilities" do
      assert {:ok, response} =
               Accounts.create(%{email: "example2@example.com", "requested_capabilities[]": "transfers"})

      assert response["capabilities"]["transfers"]
      refute response["capabilities"]["card_payments"]
    end

    test "should return an error when email is invalid" do
      assert {:error, "invalid_request_error"} = Accounts.create(%{email: "example.example.com"})
    end

    test "should return an error when country is invalid" do
      assert {:error, "invalid_request_error"} = Accounts.create(%{email: "example@example.com", country: "??"})
    end

    test "should return an error when no capabilities are requested" do
      assert {:error, "invalid_request_error"} =
               Accounts.create(%{email: "example@example.com", "requested_capabilities[]": "none"})
    end
  end

  describe "retrieve/2" do
    setup do
      Accounts.create(%{email: "example@example.com"})
    end

    test "should get account", account do
      assert {:ok, response} = Accounts.retrieve(account["id"])

      assert response["email"] == account["email"]
      assert response["country"] == account["country"]
      assert response["id"] == account["id"]
    end
  end

  describe "remove/2" do
    setup do
      Accounts.create(%{email: "example@example.com"})
    end

    test "should delete account", account do
      assert {:ok, %{"deleted" => true}} = Accounts.remove(account["id"])
      assert {:error, "invalid_request_error"} = Accounts.retrieve(account["id"])
    end
  end

  describe "update/3" do
    setup do
      Accounts.create(%{email: "example@example.com"})
    end

    test "should update account", account do
      assert {:ok, updated_account} = Accounts.update(account["id"], %{email: "example2@example.com"})

      assert updated_account["email"] == "example2@example.com"
    end
  end

  describe "list/2" do
    setup do
      Enum.each(1..3, fn i ->
        {:ok, _} = Accounts.create(%{email: "example#{i}@example.com"})
      end)
    end

    test "should list all accounts" do
      assert {:ok, response} = Accounts.list()
      assert Enum.count(response["data"]) >= 2
    end
  end

  describe "reject/3" do
    setup do
      Accounts.create(%{email: "example@example.com"})
    end

    test "should reject the account", account do
      assert {:ok, response} = Accounts.reject(account["id"], %{reason: "terms_of_service"})

      refute response["charges_enabled"]
      refute response["payouts_enabled"]
    end

    test "should not reject the account if reason is invalid", account do
      assert {:error, "invalid_request_error"} = Accounts.reject(account["id"], %{reason: "invalid reason"})
    end
  end
end
