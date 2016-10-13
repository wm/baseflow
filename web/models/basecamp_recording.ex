defmodule Baseflow.BasecampRecording do
  use Baseflow.Web, :model

  schema "basecamp_recordings" do
    field :basecamp_id, :integer
    field :status, :string
    field :type, :string
    field :url, :string
    field :app_url, :string
    field :title, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:basecamp_id, :status, :type, :url, :app_url, :title, :content])
    |> validate_required([:basecamp_id, :status, :type, :url, :app_url, :title, :content])
  end
end
