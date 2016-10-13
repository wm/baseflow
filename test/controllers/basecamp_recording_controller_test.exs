defmodule Baseflow.BasecampRecordingControllerTest do
  use Baseflow.ConnCase

  alias Baseflow.BasecampRecording
  @api_attrs %{app_url: "some content", id: 42, content: "some content", status: "some content", title: "some content", type: "some content", url: "some content"}
  @valid_attrs %{app_url: "some content", basecamp_id: 42, content: "some content", status: "some content", title: "some content", type: "some content", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, basecamp_recording_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    basecamp_recording = Repo.insert! %BasecampRecording{}
    conn = get conn, basecamp_recording_path(conn, :show, basecamp_recording)
    assert json_response(conn, 200)["data"] == %{"id" => basecamp_recording.id,
      "basecamp_id" => basecamp_recording.basecamp_id,
      "status" => basecamp_recording.status,
      "type" => basecamp_recording.type,
      "url" => basecamp_recording.url,
      "app_url" => basecamp_recording.app_url,
      "title" => basecamp_recording.title,
      "content" => basecamp_recording.content}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, basecamp_recording_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, basecamp_recording_path(conn, :create), recording: @api_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(BasecampRecording, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, basecamp_recording_path(conn, :create), recording: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    basecamp_recording = Repo.insert! %BasecampRecording{}
    conn = put conn, basecamp_recording_path(conn, :update, basecamp_recording), basecamp_recording: @api_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(BasecampRecording, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    basecamp_recording = Repo.insert! %BasecampRecording{}
    conn = put conn, basecamp_recording_path(conn, :update, basecamp_recording), basecamp_recording: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    basecamp_recording = Repo.insert! %BasecampRecording{}
    conn = delete conn, basecamp_recording_path(conn, :delete, basecamp_recording)
    assert response(conn, 204)
    refute Repo.get(BasecampRecording, basecamp_recording.id)
  end
end
