defmodule ParkinsonsAndMe.QuoteTest do
  use ParkinsonsAndMe.ModelCase

  alias ParkinsonsAndMe.Quote

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
