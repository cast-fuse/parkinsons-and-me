defmodule ParkinsonsAndMe.Repo.Migrations.AddServiceShortcode do
  use Ecto.Migration

  def up do
    alter table(:services) do
      add :shortcode, :string
    end
  end

  def down do
    alter table(:services) do
      remove :shortcode
    end
  end
end
