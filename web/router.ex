defmodule Baseflow.Router do
  use Baseflow.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Baseflow do
    pipe_through :api

    resources "/basecamp_recordings", BasecampRecordingController, except: [:new, :edit]   
  end

  scope "/", Baseflow do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/basecamp_recordings", BasecampRecordingController, except: [:new, :edit]   
  end
end
