defmodule ParkinsonsAndMe.Repo.Migrations.AddServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :title, :string
      add :body, :string
      add :cta, :string
      add :url, :string
    end
  end
end
