defmodule Baseflow.Chatter.Flowdock do
  def start_link(notification, ref, owner) do
    Task.start_link(__MODULE__, :fetch, [notification, ref, owner])
  end

  def fetch(notification, ref, owner) do
    # do something here to send data to Flowdock
  end
end
