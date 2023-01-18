require 'rails_helper'

RSpec.describe WalletSerializer do
  describe 'serialize' do
    let(:wallet) { create :wallet }
    let(:serialized_hash) { WalletSerializer.new(wallet).serializable_hash }

    it 'get serailized fields' do
      expect(serialized_hash[:currency_name]).to eq(wallet.currency_name)
      expect(serialized_hash[:amount]).to eq(wallet.amount)
      expect(serialized_hash[:symbol]).to eq(wallet.symbol)
      expect(serialized_hash[:pubkey]).to eq(wallet.pubkey)
      expect(serialized_hash[:pkey]).to eq(wallet.pkey[0, 5])
      expect(serialized_hash[:available]).to eq(wallet.available)
      expect(serialized_hash[:address]).to eq(wallet.address)
    end
  end
end