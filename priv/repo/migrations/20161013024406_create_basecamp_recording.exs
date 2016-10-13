defmodule Baseflow.Repo.Migrations.CreateBasecampRecording do
  use Ecto.Migration

  def change do
    create table(:basecamp_recordings) do
      add :basecamp_id, :integer
      add :status, :string
      add :type, :string
      add :url, :string
      add :app_url, :string
      add :title, :text
      add :content, :text

      timestamps()
    end

  end
end
