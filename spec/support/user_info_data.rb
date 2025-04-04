# frozen_string_literal: true

UserInfoData = Data.define(:id, :name, :real_name, :is_bot, :is_app_user) do
  def self.build(id: "", name: "", real_name: "", is_bot: false, is_app_user: false)
    new(id:, name:, real_name:, is_bot:, is_app_user:)
  end
end
