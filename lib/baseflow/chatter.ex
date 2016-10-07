defmodule Baseflow.Chatter do
  @backends [Baseflow.Chatter.Flowdock]

  def start_link(backend, notification, ref, owner) do
    backend.start_link(notification, ref, owner)
  end

  def compute(notification, opts \\ []) do
    backends = opts[:backends] || @backends

    backends
    |> Enum.map(&spawn_notification(&1, notification))
  end

  defp spawn_notification(backend, notification) do
    ref = make_ref()
    opts = [backend, notification, ref, self()]
    {:ok, pid} = Supervisor.start_child(Baseflow.Chatter.Supervisor, opts)
    {pid, ref}
  end
end
