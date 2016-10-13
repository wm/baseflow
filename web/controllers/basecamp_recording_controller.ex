defmodule Baseflow.BasecampRecordingController do
  use Baseflow.Web, :controller

  alias Baseflow.BasecampRecording

  def index(conn, _params) do
    basecamp_recordings = Repo.all(BasecampRecording)
    render(conn, "index.json", basecamp_recordings: basecamp_recordings)
  end

  def create(conn, %{"basecamp_recording" => basecamp_recording_params}) do
    changeset = BasecampRecording.changeset(%BasecampRecording{}, basecamp_recording_params)

    case Repo.insert(changeset) do
      {:ok, basecamp_recording} ->
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

  def show(conn, %{"id" => id}) do
    basecamp_recording = Repo.get!(BasecampRecording, id)
    render(conn, "show.json", basecamp_recording: basecamp_recording)
  end

  def update(conn, %{"id" => id, "basecamp_recording" => basecamp_recording_params}) do
    basecamp_recording = Repo.get!(BasecampRecording, id)
    changeset = BasecampRecording.changeset(basecamp_recording, basecamp_recording_params)

    case Repo.update(changeset) do
      {:ok, basecamp_recording} ->
        render(conn, "show.json", basecamp_recording: basecamp_recording)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Baseflow.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    basecamp_recording = Repo.get!(BasecampRecording, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(basecamp_recording)

    send_resp(conn, :no_content, "")
  end
end
