defmodule Flowdock.Message do
  @derive [Poison.Encoder]
  defstruct [:event, :author, :title, :body, :external_thread_id, :thread]
end
