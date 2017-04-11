defmodule What3things.Answer do
  use What3things.Web, :model

  schema "answers" do
    field :answers, {:map, :boolean}
    belongs_to :user, What3things.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:answers, :user_id])
    |> validate_required([:answers, :user_id])
  end
end
