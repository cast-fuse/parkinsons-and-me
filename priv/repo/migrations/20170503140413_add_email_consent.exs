defmodule ParkinsonsAndMe.Repo.Migrations.AddEmailConsent do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :email_consent, :boolean, default: false
    end
  end

  def down do
    alter table(:users) do
      remove :email_consent
    end
  end
end
