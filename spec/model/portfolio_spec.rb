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

  describe 'row_order' do
    context 'when position :up' do
      let(:user) { create(:user) }
      let!(:first_portfolio) { create(:portfolio, user: user, row_order: -541081600) }
      let!(:second_portfolio) { create(:portfolio, user: user, row_order: -104610816) }

      before { second_portfolio.update(row_order: -741081600) }
      it { expect(user.portfolios.second.row_order_rank).to eq 0 }
    end

    context 'when position :down' do
      let(:user) { create(:user) }
      let!(:first_portfolio) { create(:portfolio, user: user, row_order: -104610816) }
      let!(:second_portfolio) { create(:portfolio, user: user, row_order: -541081600) }

      before { second_portfolio.update(row_order: 146110310) }
      it { expect(user.portfolios.second.row_order_rank).to eq 1 }
    end
  end
end
