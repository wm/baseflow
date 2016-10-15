defmodule Flowdock.Thread do
  @derive [Poison.Encoder]
  defstruct [:title, :fields, :body, :external_url, :status, :body]
end
