# frozen_string_literal: true
class Portfolio < ApplicationRecord
  include RankedModel

  validates :title, presence: true

  belongs_to :user
  has_many :portfolio_stocks, primary_key: :id, foreign_key: :portfolio_id, dependent: :destroy
  has_many :stocks, through: :portfolio_stocks

  ranks :row_order, with_same: :user_id
end
