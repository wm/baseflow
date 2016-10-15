defmodule Flowdock.Author do
  @derive [Poison.Encoder]
  defstruct [:name, :avatar, :email]
end
