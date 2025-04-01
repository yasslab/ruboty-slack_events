# frozen_string_literal: true

require "logger"
require "forwardable"

module Ruboty
  module SlackEvents
    module Logger
      class << self
        extend Forwardable

        def instance
          @instance ||= ::Logger.new($stderr, log_level)
        end

        def log_level #: Integer
          case ENV.fetch("DEBUG", nil)
          when "1", "true"
            ::Logger::Severity::DEBUG
          when "2", "info"
            ::Logger::Severity::INFO
          else
            ::Logger::Severity::WARN
          end
        end

        delegate %i[debug? info? warn? error? fatal?] => :instance
        delegate %i[debug info warn error fatal] => :instance
      end
    end
  end
end
