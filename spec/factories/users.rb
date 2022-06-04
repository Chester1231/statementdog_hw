# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@exmaple.com" }
    password { Digest::SHA1.hexdigest('statementdogpassword') }
  end
end
