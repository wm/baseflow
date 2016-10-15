defmodule Baseflow.Repo.Migrations.AddFieldsToBasecampRecording do
  use Ecto.Migration

  def change do
    alter table(:basecamp_recordings) do
      add :parent_id, :integer
      add :parent_app_url, :string
    end
  end
end
