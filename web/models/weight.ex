defmodule ParkinsonsAndMe.Weight do
  use ParkinsonsAndMe.Web, :model

  schema "weights" do
    field :weight, :float
    belongs_to :quote, ParkinsonsAndMe.Quote
    belongs_to :service, ParkinsonsAndMe.Service
  end

  @service_quote_error_message "Must be a unique service-quote pair"

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:weight, :quote_id, :service_id])
    |> unique_constraint(:unique_service_quote_pair, name: :weights_quote_id_service_id_index, message: @service_quote_error_message)
    |> validate_required([:quote_id, :service_id, :weight])
  end
end
