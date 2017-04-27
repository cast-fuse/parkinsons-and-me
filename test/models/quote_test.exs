defmodule What3things.QuoteTest do
  use What3things.ModelCase

  alias What3things.Quote

  @valid_attrs %{body: "quote body"}
  @invalid_attrs %{}

  test "changeset with valid body" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Quote.changeset(%Quote{}, @invalid_attrs)
    refute changeset.valid?
  end
end
