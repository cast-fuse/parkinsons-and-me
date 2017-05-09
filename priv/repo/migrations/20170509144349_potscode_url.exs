defmodule ParkinsonsAndMe.Repo.Migrations.PotscodeUrl do
  use Ecto.Migration

  def up do
    alter table(:services) do
      add :location_based_url, :boolean, default: false
    end
  end

  def down do
    alter table(:services) do
      remove :location_based_url
    end
  end
end
