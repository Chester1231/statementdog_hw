# frozen_string_literal: true
class Stock < ApplicationRecord
  has_many :stock_portfolios, primary_key: :ticker, foreign_key: :ticker
  has_many :portfolios, through: :stock_portfolios

  scope :available, -> { where(deleted_at: nil)}
end
