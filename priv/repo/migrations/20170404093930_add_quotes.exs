defmodule What3things.Repo.Migrations.AddQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :body, :string
    end
  end
end
