# frozen_string_literal: true

require "async"
require "async/http/endpoint"
require "async/websocket/client"

require "slack-ruby-client"
require "json"

module Ruboty
  module SlackEvents
    module Api
      class SocketClient
        attr_reader :slack_client #: Slack::Web::Client

        # @rbs slack_client: Slack::Web::Client
        def initialize(slack_client:, auto_reconnect: false)
          @slack_client = slack_client
          @auto_reconnect = auto_reconnect
        end

        def connect(&callback) #: Async::Task
          res = slack_client.apps_connections_open #: Slack::Messages::Message
          raise res.error unless res.ok

          url = res.url
          endpoint = Async::HTTP::Endpoint.parse(url)

          Async do
            Async::WebSocket::Client.connect(endpoint) do |connection|
              while (payload = connection.read) #: Protocol::WebSocket::TextMessage
                response = payload.to_h
                message = Slack::Messages::Message.new(response)

                if message.envelope_id
                  # https://api.slack.com/apis/socket-mode#acknowledge
                  ack_message = Protocol::WebSocket::TextMessage.generate({ envelope_id: message.envelope_id })
                  ack_message.send(connection)
                  connection.flush
                end

                begin
                  callback&.call(message)
                rescue StandardError => e
                  SlackEvents::Logger.error("UnhandledError on socket API callback") { e.full_message }
                end
              end
            end
          end
        end
      end
    end
  end
end
