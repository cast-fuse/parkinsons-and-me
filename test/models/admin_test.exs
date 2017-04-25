defmodule What3things.AdminTest do
  use What3things.ModelCase
  alias What3things.Admin

  @valid_attrs %{user_name: "admin", password_hash: "1234567"}
  @invalid_attrs %{}

  test "admin changeset with valid attributes" do
    changeset = Admin.changeset(%Admin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Admin.changeset(%Admin{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password must be at least 6 characters" do
    attrs = %{@valid_attrs | password_hash: "a"}
    assert {:password_hash, "should be at least 6 character(s)"} in errors_on(%Admin{}, attrs)
  end

  test "password must be less than 100 characters" do
    long_pass = long_string(101)
    attrs = %{@valid_attrs | password_hash: long_pass}
    assert {:password_hash, "should be at most 100 character(s)"} in errors_on(%Admin{}, attrs)
  end
end
