# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio do
    association :user

    title { 'title' }
  end
end
