defmodule What3things.Repo.Migrations.DeJsonAnswers do
  use Ecto.Migration

  def up do
    alter table(:answers) do
      remove :answers
      remove :user_id
      remove :uuid
      remove :inserted_at
      remove :updated_at
      add :quote_id, references(:quotes, on_delete: :delete_all)
      add :answer_set_id, references(:answer_sets, on_delete: :delete_all)
      add :answer, :boolean
    end
    drop_if_exists index(:answers, [:user_id])
  end

  def down do
    alter table(:answers) do
      add :answers, {:map, :boolean}
      add :user_id, references(:users, on_delete: :delete_all)
      add :uuid, :string
      remove :quote_id
      remove :answer_set_id
      remove :answer

      timestamps()
    end
    create index(:answers, [:user_id])
  end
end
