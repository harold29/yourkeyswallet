require 'rails_helper'

RSpec.describe CurrencySerializer do
  describe 'serialize' do
    let(:currency) { create :currency }

    let(:serialized_fields) { CurrencySerializer.new(currency).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:name]).to eq(currency.name)
      expect(serialized_fields[:code]).to eq(currency.code)
      expect(serialized_fields[:symbol]).to eq(currency.symbol)
    end
  end
end