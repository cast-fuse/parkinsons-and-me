defmodule What3things.Service do
  use What3things.Web, :model
  alias What3things.Service

  schema "services" do
    field :title, :string
    field :body, :string
    field :cta, :string
    field :url, :string
    field :early_onset, :boolean
    field :shortcode, :string
  end

  @valid_fields [:title, :body, :cta, :url, :early_onset, :shortcode]
  @required_fields [:title, :body, :cta, :url, :early_onset, :shortcode]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_fields)
    |> validate_required(@required_fields)
  end

  def services_by_id(ids) do
    ids = format_ids(ids)
    from s in Service, where: s.id in ^ids
  end

  defp format_ids(ids) do
    if is_list(ids) do ids else ids_to_list(ids)  end
  end

  defp ids_to_list(ids) do
    ids
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
