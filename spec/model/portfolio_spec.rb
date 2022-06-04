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

  describe '.ordered_by_row_order' do
    let!(:first_portfolio) { create(:portfolio, row_order: 1) }
    let!(:second_portfolio) { create(:portfolio, row_order: 3) }
    let!(:third_portfolio) { create(:portfolio, row_order: 2) }

    subject { described_class.ordered_by_row_order }

    it { expect(subject).to eq [first_portfolio, third_portfolio ,second_portfolio] }
  end

  # generally relation not testing with rspec, but if wanted it can testing with shoulda-matchers
  # context 'destroys dependent portfolio_stocks'
end
