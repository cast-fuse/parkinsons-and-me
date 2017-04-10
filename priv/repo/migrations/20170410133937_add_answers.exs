defmodule What3things.Repo.Migrations.AddAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :user_id, references(:users)
      add :answers, {:map, :boolean}

      timestamps()
    end
  end
end
