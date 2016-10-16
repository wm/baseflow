defmodule Baseflow.BasecampRecordingController do
  use Baseflow.Web, :controller

  alias Baseflow.BasecampRecording

  def create(conn, %{"flow_token" => flow_token, "recording" => recording_params}) do
    recording_params = map_params(recording_params)
    changeset = BasecampRecording.changeset(%BasecampRecording{}, recording_params)

    case Repo.insert(changeset) do
      {:ok, basecamp_recording} ->

        Baseflow.Broadcaster.sync_notify({flow_token, basecamp_recording})

        conn
        |> put_status(:created)
        |> put_resp_header("location", basecamp_recording_path(conn, :show, basecamp_recording))
        |> render("show.json", basecamp_recording: basecamp_recording)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Baseflow.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp map_params(recording_params) do
    IO.puts "parent_id: #{recording_params["parent"]["id"]}"
    recording_params
    |> Dict.put_new("basecamp_id", recording_params["id"])
    |> Dict.delete("id")
    |> Dict.put_new("parent_app_url", recording_params["parent"]["app_url"])
    |> Dict.put_new("parent_id", recording_params["parent"]["id"])
  end
end
