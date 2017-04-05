defmodule What3things.Quote do
  use What3things.Web, :model

  @derive{Poison.Encoder, only: [:body, :id]}
  schema "quotes" do
    field :body, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
