defmodule What3things.Weight do
  use What3things.Web, :model

  schema "weights" do
    field :weight, :float
    belongs_to :quote, What3things.Quote
    belongs_to :service, What3things.Service
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:weight, :quote_id, :service_id])
    |> validate_required([:quote_id, :service_id, :weight])
  end
end
