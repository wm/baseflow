defmodule Flowdock.Message do
  @derive [Poison.Encoder]
  defstruct [:flow_token, :event, :author, :title, :body, :external_thread_id, :thread]
end
