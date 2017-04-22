defmodule What3things.AnswerSet do
  use What3things.Web, :model

  schema "answer_sets" do
    field :uuid, :string
    belongs_to :user, What3things.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :uuid])
    |> validate_required([:user_id, :uuid])
  end
end
