# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  describe 'validation' do
    context 'is valid with valid attributes' do
      let(:portfolio) { create(:portfolio) }
      it { expect(portfolio).to be_valid }
    end

    context 'is not valid without title' do
      let(:invalid_portfolio) { build(:portfolio, title: nil) }
      it { expect(invalid_portfolio).to be_invalid }
    end
  end

  # generally relation not testing with rspec, but if wanted it can testing with shoulda-matchers
  # context 'destroys dependent portfolio_stocks'
end
