defmodule What3things.Answer do
  use What3things.Web, :model

  schema "answers" do
    field :answer, :boolean
    belongs_to :quote, What3things.Quote
    belongs_to :answer_set, What3things.AnswerSet
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

  def answer_aggregates do
    from a in What3things.Answer,
      join: q in What3things.Quote,
      on: a.quote_id == q.id,
      where: a.answer == true,
      group_by: [q.body],
      order_by: [desc: count(a.answer)],
      select: %{quote: max(q.body),
                yes_count: count(a.answer)}
  end
end
