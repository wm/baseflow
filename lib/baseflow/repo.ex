# A dummy Repo that does zip
defmodule Baseflow.Repo do
  def get(module, id) do
    nil
  end

  def get_by(module, params) do
    nil
  end


  def all(Baseflow.User) do
    []
  end
  def all(_module), do: []
end
