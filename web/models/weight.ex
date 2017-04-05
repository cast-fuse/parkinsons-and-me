defmodule What3things.Weight do
  use What3things.Web, :model

  schema "weights" do
    field :weight, :float
    belongs_to :quote, What3thing.Quote
    belongs_to :service, What3thing.Service
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:weight, :quote_id, :service_id])
    |> unique_constraint([:quote_id, :service_id], message: "Service-quote pair not unique")
    |> validate_required([:quote_id, :service_id, :weight])
  end

end
