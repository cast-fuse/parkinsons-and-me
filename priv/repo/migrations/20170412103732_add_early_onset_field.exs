defmodule What3things.Repo.Migrations.AddEarlyOnsetField do
  use Ecto.Migration

  def change do
    alter table(:services) do
      add :early_onset, :boolean, default: false
    end

  end
end
