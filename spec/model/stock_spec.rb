# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'scopes' do
    describe '#available' do
      subject(:available) { described_class.available }

      context 'ticker with deleted_at' do
        before { create(:stock, :unavailable_stock) }
        it { expect(available).to be_empty }
      end

      context 'ticker without deleted_at' do
        let(:stock) { create(:stock) }
        it { expect(available).to include(stock) }
      end
    end
  end
end
