alias Experimental.{GenStage}

defmodule Baseflow.Consumer do
  @moduledoc """
  The GenEvent handler implementation is a simple consumer.
  """

  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, :ok)
  end

  # Callbacks

  def init(:ok) do
    # Starts a permanent subscription to the broadcaster
    # which will automatically start requesting items.
    {:consumer, :ok, subscribe_to: [Baseflow.Broadcaster]}
  end

  def handle_events(events, _from, state) do
    for {flow_token, recording} <- events do
      recording
      |> Baseflow.RecordingTranslator.translate
      |> Flowdock.post(flow_token)
    end
    {:noreply, [], state}
  end
end
