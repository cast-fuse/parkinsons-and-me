defmodule What3things.User do
  use What3things.Web, :model

  schema "users" do
    field :name, :string
    field :age_range, :string
    field :postcode, :string
    field :email, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :age_range, :postcode, :email])
    |> validate_required([:name, :age_range, :postcode])
  end
end
