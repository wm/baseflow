defmodule Baseflow.BasecampRecordingControllerTest do
  use Baseflow.ConnCase

  alias Baseflow.BasecampRecording
  @api_attrs %{app_url: "some content", id: 42, content: "some content", status: "some content", title: "some content", type: "some content", url: "some content", parent_id: 123123, parent_app_url: "some content"}
  @valid_attrs %{app_url: "some content", basecamp_id: 42, content: "some content", status: "some content", title: "some content", type: "some content", url: "some content", parent_id: 123123, parent_app_url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, "/webhooks/basecamp/recordings/123123", recording: @api_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(BasecampRecording, @valid_attrs)
  end

  test "does not create resource and renders errors when flow_token is missing", %{conn: conn} do
    conn = post conn, "/webhooks/basecamp/recordings", recording: @api_attrs
    assert json_response(conn, 404)["errors"] != %{}
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, "/webhooks/basecamp/recordings/123123", recording: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
