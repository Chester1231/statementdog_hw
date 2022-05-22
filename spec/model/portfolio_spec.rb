# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  context 'is valid with valid attributes' do
    let(:portfolio) { create(:portfolio) }
    it { expect(portfolio).to be_valid }
  end

  context 'is not valid without title' do
    let(:invalid_portfolio) { build(:portfolio, title: nil) }
    it { expect(invalid_portfolio).to be_invalid }
  end
end
