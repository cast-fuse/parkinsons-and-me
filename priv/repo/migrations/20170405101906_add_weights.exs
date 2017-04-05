defmodule What3things.Repo.Migrations.AddWeights do
  use Ecto.Migration

  def change do
    create table(:weights) do
      add :weight, :float
      add :quote_id, references(:quotes)
      add :service_id, references(:services)
    end
    create unique_index(:weights, [:quote_id, :service_id])
  end
end
