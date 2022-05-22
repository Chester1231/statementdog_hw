# frozen_string_literal: true
class Portfolio < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
end
