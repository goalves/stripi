defmodule Stripi.ApiCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      doctest Stripi
    end
  end
end
