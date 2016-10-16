defmodule Baseflow.BasecampRecordingController do
  use Baseflow.Web, :controller

  alias Baseflow.BasecampRecording

  def create(conn, %{"flow_token" => flow_token, "recording" => recording_params}) do
    recording_params = map_params(recording_params)
    changeset = BasecampRecording.changeset(%BasecampRecording{}, recording_params)

    if changeset.valid? do
      basecamp_recording = Ecto.Changeset.apply_changes changeset
      Baseflow.Producer.sync_notify({flow_token, basecamp_recording})

      conn
      |> put_status(:accepted)
      |> render("show.json", basecamp_recording: basecamp_recording)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Baseflow.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp map_params(recording_params) do
    recording_params
    |> Dict.put_new("basecamp_id", recording_params["id"])
    |> Dict.delete("id")
    |> Dict.put_new("parent_app_url", recording_params["parent"]["app_url"])
    |> Dict.put_new("parent_id", recording_params["parent"]["id"])
  end
end
