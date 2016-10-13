defmodule Baseflow.BasecampRecordingView do
  use Baseflow.Web, :view

  def render("index.json", %{basecamp_recordings: basecamp_recordings}) do
    %{data: render_many(basecamp_recordings, Baseflow.BasecampRecordingView, "basecamp_recording.json")}
  end

  def render("show.json", %{basecamp_recording: basecamp_recording}) do
    %{data: render_one(basecamp_recording, Baseflow.BasecampRecordingView, "basecamp_recording.json")}
  end

  def render("basecamp_recording.json", %{basecamp_recording: basecamp_recording}) do
    %{id: basecamp_recording.id,
      basecamp_id: basecamp_recording.basecamp_id,
      status: basecamp_recording.status,
      type: basecamp_recording.type,
      url: basecamp_recording.url,
      app_url: basecamp_recording.app_url,
      title: basecamp_recording.title,
      content: basecamp_recording.content}
  end
end
