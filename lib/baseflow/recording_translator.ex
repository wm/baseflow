defmodule Baseflow.RecordingTranslator do
  def translate(recording) do
    author = %Flowdock.Author{name: "Will M", avatar: "https://avatars.githubusercontent.com/u/3017123?v=3"}
    status = %Flowdock.Status{color: "green", value: "Product"}
    thread = %Flowdock.Thread{
      title: recording.title,
      body: recording.title,
      external_url: recording.parent_app_url,
      status: status,
    }
    message = %Flowdock.Message{
      event: "discussion", 
      author: author, 
      title: "<a href='#{recording.app_url}'>Answered the question</a>", 
      body: recording.content,
      external_thread_id: recording.basecamp_id,
      thread: thread,
    }
  end
end


# recording
# |> Baseflow.RecordingTranslator.translate
# |> Poison.encode!
# schema "basecamp_recordings" do
#   field :basecamp_id, :integer
#   field :status, :string
#   field :type, :string
#   field :url, :string
#   field :app_url, :string
#   field :title, :string
#   field :content, :string

#   field :parent_id, :string
#   field :parent_app_url, :string
#   timestamps()
# end
