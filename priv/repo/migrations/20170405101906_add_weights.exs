defmodule ParkinsonsAndMe.Repo.Migrations.AddWeights do
  use Ecto.Migration

  def change do
    create table(:weights) do
      add :weight, :float
      add :quote_id, references(:quotes, on_delete: :delete_all)
      add :service_id, references(:services, on_delete: :delete_all)
    end
    create unique_index(:weights, [:quote_id, :service_id])
  end
end
