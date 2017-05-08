defmodule ParkinsonsAndMe.Admin do
  use ParkinsonsAndMe.Web, :model

  schema "admins" do
    field :user_name, :string
    field :password_hash, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_name, :password_hash])
    |> unique_constraint(:user_name)
    |> validate_length(:password_hash, min: 6, max: 100)
    |> validate_required([:user_name, :password_hash])
    |> put_pass_hash()
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_hash: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
