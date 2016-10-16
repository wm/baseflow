defmodule Baseflow.BasecampRecordingTest do
  use Baseflow.ModelCase

  alias Baseflow.BasecampRecording

  @valid_attrs %{app_url: "some content", basecamp_id: 42, content: "some content", status: "some content", title: "some content", type: "some content", url: "some content", parent_id: 121212, parent_app_url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BasecampRecording.changeset(%BasecampRecording{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BasecampRecording.changeset(%BasecampRecording{}, @invalid_attrs)
    refute changeset.valid?
  end
end
