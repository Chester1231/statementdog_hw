# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    sequence(:ticker, 'A') { |char| char.next }
    market_type { 'us' }
    exchange_market { 'NASDAQ' }
    company_name { 'company_name' }
    company_description { 'company_description' }

    trait :unavailable_stock do
      deleted_at { Date.new(2021,01,01)}
    end
  end
end
