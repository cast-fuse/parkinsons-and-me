defmodule ParkinsonsAndMe.Repo.Migrations.AddAnswerSet do
  use Ecto.Migration

  def change do
    create table(:answer_sets) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :uuid, :string

      timestamps()
    end
  end
end
