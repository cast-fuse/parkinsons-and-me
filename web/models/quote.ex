defmodule What3things.Quote do
  use What3things.Web, :model
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
