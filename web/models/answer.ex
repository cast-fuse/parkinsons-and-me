defmodule ParkinsonsAndMe.Answer do
  use ParkinsonsAndMe.Web, :model

  schema "answers" do
    field :answer, :boolean
    belongs_to :quote, ParkinsonsAndMe.Quote
    belongs_to :answer_set, ParkinsonsAndMe.AnswerSet
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:answer, :quote_id, :answer_set_id])
    |> validate_required([:answer, :quote_id, :answer_set_id])
  end

  def get_by_uuid(uuid) do
    from a in ParkinsonsAndMe.Answer,
    join: s in ParkinsonsAndMe.AnswerSet,
    on: a.answer_set_id == s.id,
    where: s.uuid == ^uuid
  end

  def answer_aggregates do
    from a in ParkinsonsAndMe.Answer,
      join: q in ParkinsonsAndMe.Quote,
      on: a.quote_id == q.id,
      where: a.answer == true,
      group_by: [q.body],
      order_by: [desc: count(a.answer)],
      select: %{quote: max(q.body),
                yes_count: count(a.answer)}
  end
end
