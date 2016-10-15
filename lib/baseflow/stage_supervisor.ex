defmodule Baseflow.StageSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    children = [
      worker(Baseflow.Broadcaster, []),
      worker(Baseflow.Consumer, [], id: 1),
      worker(Baseflow.Consumer, [], id: 2),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
