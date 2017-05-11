defmodule ParkinsonsAndMe.User do
  use ParkinsonsAndMe.Web, :model
  alias ParkinsonsAndMe.{User, AnswerSet}

  schema "users" do
    field :name, :string
    field :age_range, :string
    field :postcode, :string
    field :email, :string
    field :email_consent, :boolean

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :age_range, :postcode, :email, :email_consent])
    |> validate_required([:name, :age_range, :postcode])
  end

  def get_existing({ name, postcode, age_range }) do
    from u in ParkinsonsAndMe.User,
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
