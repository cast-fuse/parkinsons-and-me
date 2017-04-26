defmodule What3things.User do
  use What3things.Web, :model
  alias What3things.{User, AnswerSet}

  schema "users" do
    field :name, :string
    field :age_range, :string
    field :postcode, :string
    field :email, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :age_range, :postcode, :email])
    |> validate_required([:name, :age_range, :postcode])
  end

  def get_existing({ name, postcode, age_range }) do
    from u in What3things.User,
    where: u.name == ^name and
           u.postcode == ^postcode and
           u.age_range == ^age_range
  end

  def get_by_answer_uuid(uuid) do
    from u in User,
    join: a in AnswerSet,
    on: u.id == a.user_id,
    where: a.uuid == ^uuid
  end
end
