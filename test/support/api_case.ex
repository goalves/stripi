defmodule Stripex.ApiCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      doctest Stripex
    end
  end
end
