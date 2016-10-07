defmodule Baseflow.PageController do
  use Baseflow.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
