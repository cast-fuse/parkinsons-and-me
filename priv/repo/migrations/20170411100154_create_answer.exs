defmodule What3things.Repo.Migrations.CreateAnswer do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :answers, {:map, :boolean}
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:answers, [:user_id])

  end
end
