defmodule ParkinsonsAndMe.AnswerSet do
  use ParkinsonsAndMe.Web, :model
  alias ParkinsonsAndMe.{Answer, AnswerSet, Weight, Service}

  schema "answer_sets" do
    field :uuid, :string
    belongs_to :user, ParkinsonsAndMe.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :uuid])
    |> validate_required([:user_id, :uuid])
  end

  def top3services(uuid) do
    from w in Weight,
      join: a in Answer,
      join: as in AnswerSet,
      join: s in Service,
      on: a.answer_set_id == as.id,
      on: w.quote_id == a.quote_id,
      on: s.id == w.service_id,
      where: as.uuid == ^uuid and
             a.answer == true and
             w.weight > 0.0,
      group_by: s.id,
      order_by: [desc: sum(w.weight)],
      limit: 3,
      select: %{service: max(s.title),
                body: max(s.body),
                cta: max(s.cta),
                url: max(s.url),
                weight: sum(w.weight)}
  end
end
