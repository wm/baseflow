defmodule Flowdock.Status do
  @derive [Poison.Encoder]
  defstruct [:color, :value]
end
