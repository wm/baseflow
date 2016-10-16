defmodule Flowdock do
  def post(message, flow_token) do
    content = %{message | flow_token: flow_token}
              |> Poison.encode!

    headers = ["User-Agent": "Baseflow", "Content-Type": "application/json"]

    resp = HTTPotion.post(
      "https://api.flowdock.com/messages",
      [body: content, headers: headers]
    )
    # For debugging purposes
    IO.inspect {content, resp}
  end
end
