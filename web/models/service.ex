defmodule What3things.Service do
  use What3things.Web, :model

  @derive{Poison.Encoder, only: [:title, :body, :id, :cta, :url]}
  schema "services" do
    field :title, :string
    field :body, :string
    field :cta, :string
    field :url, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :cta, :url])
    |> validate_required([:title, :body, :cta, :url])
  end

end
