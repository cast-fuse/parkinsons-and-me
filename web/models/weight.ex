defmodule What3things.Weight do
  use What3things.Web, :model

  @derive{Poison.Encoder, only: [:weight, :quote_id, :service_id]}
  schema "weights" do
    field :weight, :float
    belongs_to :quote, What3things.Quote
    belongs_to :service, What3things.Service
  end

  @service_quote_error_message "Must be a unique service-quote pair"

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:weight, :quote_id, :service_id])
    |> unique_constraint(:unique_service_quote_pair, name: :weights_quote_id_service_id_index, message: @service_quote_error_message)
    |> validate_required([:quote_id, :service_id, :weight])
  end
end
