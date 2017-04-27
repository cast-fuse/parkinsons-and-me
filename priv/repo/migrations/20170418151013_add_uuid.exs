defmodule What3things.Repo.Migrations.AddUuid do
  use Ecto.Migration

  def up do
    alter table(:answers) do
      add :uuid, :string
    end
  end

  def down do
    alter table(:answers) do
      remove :uuid
    end
  end
end
