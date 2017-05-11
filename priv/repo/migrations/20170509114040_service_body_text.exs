defmodule ParkinsonsAndMe.Repo.Migrations.ServiceBodyText do
  use Ecto.Migration

  def up do
    alter table(:services) do
      remove :body
      add :body, :text
    end
  end

  def down do
    alter table(:services) do
      remove :body
      add :body, :string
    end
  end
end
