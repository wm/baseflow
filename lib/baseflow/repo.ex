defmodule Baseflow.Repo do
  # use Ecto.Repo, otp_app: :baseflow
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
