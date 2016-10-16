defmodule Baseflow.FlowDiscussion do
  def from_basecamp_recording(recording) do
    # Hard coded until I can figure out how to get this from Basecamp
    # I have a support ticket open with them!
    author = %Flowdock.Author{name: "Will M", avatar: "https://avatars.githubusercontent.com/u/3017123?v=3"}

    today = Timex.today 
    day = Timex.format!(today, "%A", :strftime)
    status = %Flowdock.Status{color: "green", value: day}

    thread = %Flowdock.Thread{
      title: recording.title,
      body: recording.title,
      external_url: recording.parent_app_url,
      status: status,
    }

    message = %Flowdock.Message{
      event: "discussion", 
      author: author, 
      title: "<a href='#{recording.app_url}'>see this on</a>", 
      body: recording.content,
      external_thread_id: "#{recording.parent_id}_#{today}", # new thread daily
      thread: thread,
    }
  end
end
