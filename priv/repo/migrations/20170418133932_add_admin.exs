defmodule What3things.Repo.Migrations.AddAdmin do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :user_name, :string
      add :password_hash, :string
    end
    create unique_index(:admins, [:user_name])
  end
end
