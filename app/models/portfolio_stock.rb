# frozen_string_literal: true
class PortfolioStock < ApplicationRecord
  belongs_to :stock, primary_key: :ticker, foreign_key: :ticker
  belongs_to :portfolio, primary_key: :id, foreign_key: :portfolio_id
end
