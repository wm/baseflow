defmodule Baseflow.Factory do
  use ExMachina.Ecto, repo: Baseflow.Repo

  def basecamp_recording_factory do
    %Baseflow.BasecampRecording{
      id: 258855865,
      status: "active",
      created_at: "2016-10-12T21:54:42.058-04:00",
      updated_at: "2016-10-12T21:54:42.067-04:00",
      type: "Question::Answer",
      url: "https://3.basecampapi.com/3320898/buckets/1636980/question_answers/258855865.json",
      app_url: "https://3.basecamp.com/3320898/buckets/1636980/questions/258854860/answers/2016-10-12#__recording_258855865",
      title: "Answer to “What did you do yesterday, what are you doing today, and are there blockers?”",
      content: "<div><strong>Today:</strong></div><ul><li>Meetings: A; B; C.</li><li>Maker: A;B;C.</li></ul><div><strong>Yesterday:</strong></div><ul><li>Meetings: A; B; C.</li><li>Maker: A;B;C.</li></ul>"
    }
  end
end
