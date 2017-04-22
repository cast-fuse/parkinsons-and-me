defmodule What3things.Answer do
  use What3things.Web, :model

  schema "answers" do
    field :answer, :boolean
    belongs_to :quote, What3things.Quote
    belongs_to :answer_set, What3things.AnswerSet

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:answer, :quote_id, :answer_set_id])
    |> validate_required([:answer, :quote_id, :answer_set_id])
  end

  def get_by_uuid(uuid) do
    from a in What3things.Answer,
    join: s in What3things.AnswerSet,
    on: a.answer_set_id == s.id,
    where: s.uuid == ^uuid
  end
end
