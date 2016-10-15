defmodule Flowdock do
  def post(_json, flow) do
    IO.inspect {self(), flow}
  end
end
