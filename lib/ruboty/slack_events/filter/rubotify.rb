# frozen_string_literal: true

module Ruboty
  module SlackEvents
    module Filter
      # Convert Slack text format to Ruboty format
      class Rubotify
        attr_reader :resolvers #: Resolvers

        # @rbs resolvers: Resolvers
        def initialize(resolvers:)
          @resolvers = resolvers
        end

        # @rbs text: String
        def call(text) #: String
          replace_user_mentions(text)
        end

        # @rbs text: String
        def replace_user_mentions(text) #: String
          text.gsub(/<@(?<user_id>\w+)>/) do |user_mention|
            user_id = Regexp.last_match[:user_id]

            user_info = resolvers.user_resolver.user_info_by_id(user_id)

            next user_mention unless user_info

            "@#{user_info.name}"
          end
        end
      end
    end
  end
end
