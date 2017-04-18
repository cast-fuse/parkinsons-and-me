defmodule What3things.Repo.Migrations.AddUuid do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      add :uuid, :string
    end
  end
end
