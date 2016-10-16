# Baseflow

This is a simple Elixir Phoenix app that pipes Basecamp Webhooks to Flowdock. 

This toy application uses the [experimental GenStage
behaviour](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/). The
motivation is two fold: 

1. Pipe specific updates in Basecamp to specific Flowdock Inbox's
2. To learn about Elixir, Phoenix patterns/behaviours.

I chose the GenStage behaviour to:

- have a simple broadcast API
- allow concurrency
- provide buffering (in case the processing of an event is slower than the
  rate of incoming events)

Currently it uses the default dispatcher but I toyed with using the
BroadcastDispatcher to send to multiple channles (for example Slack, Flowdock,
etc.)

This app has two main parts: Web JSON API and Broadcaster.

### The Web JSON API
This is a simple create action that will accept JSON and create a
Baseflow.Recording. It will then broadcast that recording to a given Flowdock
flow.

    Baseflow.Broadcaster.sync_notify({flow, recording})

### The Broadcaster

Using the GenStage behaviour we need to have the Broadcaster running and
consumers subscribed. It has its own supervisor (StageSupervisor) to manage
this.

The StageSupervisor has the Broadcaster and two Consumers as children (we
probably do not need multiple consumers here tbh).

The consumers will take any events built up in the Broadcaster and process
them. Events here are {flow_name, Baseflow.Recording} tuples. The recording is
serialized into Flowdock format and then sent to Flowdock
    
    recording
    |> Baseflow.RecordingTranslator.translate
    |> Flowdock.post(flow)

### Usage & Setup

Once set up updates to configured threads will be pushed to Flowdock as a daily
discussion. All updates during a day will be appended to the discussion. New
disucssion will be created when there is an update.


- Baseflow will need to be added to your orginization's Flowdock
- You will need to add the integration to your flow (and copy the FLOW_TOKEN)
- You will need to add a webhook on a Basecamp thread `https://<SERVER_URL>/webhooks/basecamp/recordings/<FLOW_TOKEN>`

#### Validating GenStage does its job

Add a `Process.sleep(3000)` to the `Consumer.handle_events/3` to simulate a
slow downstream API. Send a few requests to the server (in quick succession)
and watch how quick they each respond even though the pushes to Flowdock as
delayed.
