defmodule ParkinsonsAndMe.Repo.Migrations.RemoveWidgetShortcode do
  use Ecto.Migration

  def up do
    alter table(:services) do
      remove :shortcode
    end
  end

  def down do
    alter table(:services) do
      add :shortcode, :string
    end
  end
end
