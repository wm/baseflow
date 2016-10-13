defmodule Baseflow.Chatter.Flowdock do
  # Start the work
  def start_link(notification, ref, owner) do
    Task.start_link(__MODULE__, :publish, [notification, ref, owner])
  end

  def publish(notification, ref, owner) do
    # do something here to send data to Flowdock
  end
end
