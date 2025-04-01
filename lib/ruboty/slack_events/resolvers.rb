# frozen_string_literal: true

module Ruboty
  module SlackEvents
    class Resolvers
      attr_reader :slack_client #: ::Slack::Web::Client

      # @rbs slack_client: ::Slack::Web::Client
      def initialize(slack_client:)
        @slack_client = slack_client
      end

      def user_resolver
        @user_resolver ||= UserResolver.new(slack_client:)
      end
    end
  end
end

require_relative "resolvers/user_resolver"
