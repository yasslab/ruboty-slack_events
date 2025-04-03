# frozen_string_literal: true

module Ruboty
  module SlackEvents
    class Error < StandardError; end
  end
end

require_relative "slack_events/version"

require_relative "slack_events/api/socket_client"
require_relative "slack_events/filter/slackify"
require_relative "slack_events/filter/rubotify"
require_relative "slack_events/resolvers"
require_relative "slack_events/logger"

require "ruboty/adapters/slack_events"
