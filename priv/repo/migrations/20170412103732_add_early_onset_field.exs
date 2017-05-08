defmodule ParkinsonsAndMe.Repo.Migrations.AddEarlyOnsetField do
  use Ecto.Migration

  def up do
    alter table(:services) do
      add :early_onset, :boolean, default: false
    end
  end

  def down do
    alter table(:services) do
      remove :early_onset
    end
  end
end
