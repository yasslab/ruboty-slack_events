# frozen_string_literal: true

module Ruboty
  module Adapters
    class SlackEvents
      # Handle events from Slack Events API
      class SlackEventsHandler
        attr_reader :adapter #: Ruboty::Adapters::SlackEvents

        # @rbs adapter: Ruboty::Adapters::SlackEvents
        def initialize(adapter)
          @adapter = adapter
        end

        # @rbs message: Slack::Messages::Message -- Event payload of Slack Events API
        def handle_event(message) #: void
          Ruboty::SlackEvents::Logger.debug("handle_event") { message.to_json }

          case message.type
          when "message"
            on_message(message)
          when "events_api"
            on_events_api(message)
          when "event_callback"
            on_event_callback(message)
          end
        end

        # @rbs message: Slack::Messages::Message -- `message` type event
        def on_message(message) #: void
          user_id = message.user || message.bot_id
          user = user_id && adapter.resolvers.user_resolver.user_info_by_id(user_id)
          channel = message.channel

          return if message.subtype == "bot_message" && adapter.ignore_bot_message?

          message_for_robot = {
            body: adapter.rubotify.call(message.text),
            from: channel,
            from_name: user&.name,
            to: channel,
            thread_ts: message.thread_ts
          } #: receivedMessage

          Ruboty::SlackEvents::Logger.debug("robot.receive") { message_for_robot.to_json }

          adapter.robot.receive(message_for_robot)
        end

        # @rbs message: Slack::Messages::Message -- `event_callback` type event
        def on_event_callback(message)
          handle_event(message.event)
        end

        # @rbs message: Slack::Messages::Message -- `events_api` type event
        def on_events_api(message)
          handle_event(message.payload)
        end
      end
    end
  end
end
