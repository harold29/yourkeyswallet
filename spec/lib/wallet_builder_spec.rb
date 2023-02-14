require 'rails_helper'

RSpec.describe WalletBuilder do
  subject { described_class.run(user, currency.currency_kind) }

  context '#create_wallet' do
    describe 'with valid params' do
      let(:user) { create :user }
      let(:currency) { create :currency, name: 'Bitcoin', code: 'BTC', currency_kind: 'bitcoin' }
      let(:keys) { { addr: "2847502485943579834adfadhdxvbr", pub_key: '453425245245', priv_key: '249857298475'} }

      before do
        allow(KeyGenerator).to receive(:generate).and_return(keys)
      end
      
      it 'returns a Wallet object with keys' do
        wallet = subject

        expect(wallet.user).to eq(user)
        expect(wallet.currency).to eq(currency)
        expect(wallet.address).to eq(keys[:addr])
        expect(wallet.pubkey).to eq(keys[:pub_key])
        expect(wallet.pkey).to eq(keys[:priv_key])
      end
    end

    # describe 'with not supported currency' do
    #   let(:user) { create :user }
    #   let(:currency) { create :currency }
    #   let(:keys) { { addr: "2847502485943579834adfadhdxvbr", pub_key: '453425245245', priv_key: '249857298475'} }
      
    #   it 'returns a Wallet object with keys' do
    #     # wallet = subject.create_wallet

    #     expect{ KeyGenerator }.to raise_error(KeyGenerator::CurrencyNotSupportedError)
    #   end
    # end
  end
end