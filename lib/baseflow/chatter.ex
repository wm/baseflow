defmodule Baseflow.Chatter do
  @backends [Baseflow.Chatter.Flowdock]

  # Backend
  #
  # Proxy to the specific backend (e.g. Flowdock, Logs, etc.)
  def start_link(backend, notification, ref, owner) do
    backend.start_link(notification, ref, owner)
  end

  # Client (frontend)
  #
  # Publishes to all the backends via async by dynamically starting supervised
  # children (e.g. Flowdock.start_link)
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
