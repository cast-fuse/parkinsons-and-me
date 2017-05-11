defmodule ParkinsonsAndMe.Quote do
  use ParkinsonsAndMe.Web, :model
  import Ecto.Query

  schema "quotes" do
    field :body, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end

  def in_order(query) do
    from q in query, order_by: q.id
  end
end
