defmodule What3things.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age_range, :string
      add :postcode, :string
      add :email, :string

      timestamps()
    end
  end
end
