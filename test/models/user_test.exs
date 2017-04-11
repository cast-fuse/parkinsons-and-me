defmodule What3things.UserTest do
  use What3things.ModelCase

  alias What3things.User

  @valid_attrs %{age_range: "some content", email: "some content", name: "some content", postcode: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
