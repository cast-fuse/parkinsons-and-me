defmodule What3things.Answer do
  use What3things.Web, :model

  schema "answers" do
    field :answers, {:map, :boolean}
    field :uuid, :string
    belongs_to :user, What3things.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:answers, :user_id, :uuid])
    |> validate_required([:answers, :user_id, :uuid])
  end
end
