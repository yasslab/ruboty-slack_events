# frozen_string_literal: true

require "spec_helper"
require "support/user_info_data"

RSpec.describe Ruboty::SlackEvents::Filter::Rubotify do
  let(:rubotify) { described_class.new(resolvers:) }
  let(:resolvers) { instance_double(Ruboty::SlackEvents::Resolvers, user_resolver:) }
  let(:user_resolver) do
    instance_double(Ruboty::SlackEvents::Resolvers::UserResolver).tap do |resolver|
      allow(resolver).to receive(:user_info_by_id).and_return(nil)
    end
  end

  describe "#call" do
    subject { rubotify.call(text) }

    describe "user mentions" do
      let(:text) { "Hello <@U12345678>!" }

      context "when the user exists" do
        before do
          allow(user_resolver).to receive(:user_info_by_id).with("U12345678").and_return(user_info)
        end

        let(:user_info) { UserInfoData.build(name: "alice") }

        it "replaces the user mention with the Ruboty format" do
          expect(subject).to eq("Hello @alice!")
        end
      end

      context "when the user does not exist" do
        it "does not replace the user mention" do
          expect(subject).to eq(text)
        end
      end
    end

    describe "links" do
      context "when the text contains a link without text" do
        let(:text) { "Hello <https://example.com>" }

        pending "replaces the link into the url with the Ruboty format" do
          expect(subject).to eq("Hello https://example.com")
        end
      end

      context "when the text contains a link with text" do
        let(:text) { "Hello <https://example.com|Example Com>" }

        pending "replaces the link into the text with the Ruboty format" do
          expect(subject).to eq("Hello Example Com")
        end
      end
    end
  end
end
