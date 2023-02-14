require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/wallets", type: :request do
  describe "GET /index" do
    let(:index_wallets_url) { '/wallets' }
    let(:user) { create :user }
    let(:wallet_1) { create :wallet, user: user }
    let(:wallet_2) { create :wallet, user: user }
    let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }

    before do
      wallet_1
      wallet_2
    end

    it "renders a successful response" do
      get wallets_url, headers: headers, as: :json

      expect(response).to be_successful
    end

    it 'returns all created wallets for user' do
      get wallets_url, headers: headers, as: :json

      json_body = JSON.parse(body)

      expect(json_body[0]["currency_name"]).to eq(wallet_1.currency_name)
      expect(json_body[0]["symbol"]).to eq(wallet_1.symbol)
      expect(json_body[0]["amount"].to_f).to eq(wallet_1.amount.to_f)
      expect(json_body[0]["pubkey"]).to eq(wallet_1.pubkey)
      expect(json_body[0]["pkey"]).to eq(wallet_1.pkey[0, 5])
      expect(json_body[0]["address"]).to eq(wallet_1.address)

      expect(json_body[1]["currency_name"]).to eq(wallet_2.currency_name)
      expect(json_body[1]["symbol"]).to eq(wallet_2.symbol)
      expect(json_body[1]["amount"].to_f).to eq(wallet_2.amount.to_f)
      expect(json_body[1]["pubkey"]).to eq(wallet_2.pubkey)
      expect(json_body[1]["pkey"]).to eq(wallet_2.pkey[0, 5])
      expect(json_body[1]["address"]).to eq(wallet_2.address)
    end
  end

  describe "GET /show" do
    context 'when wallet is created and belongs to user' do
      let(:user) { create :user }
      let(:wallet) { create :wallet, user: user }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:show_attributes) { { id: wallet.id } }


      it "renders a successful response" do
        get wallet_url(show_attributes), headers: headers, as: :json
        expect(response).to be_successful
      end

      it "returns a serialized wallet" do
        get wallet_url(show_attributes), headers: headers, as: :json

        json_body = JSON.parse(body)

        expect(json_body['currency_name']).to eq(wallet.currency_name)
        expect(json_body['symbol']).to eq(wallet.symbol)
        expect(json_body['amount']).to eq(wallet.amount.to_f.to_s)
        expect(json_body['pubkey']).to eq(wallet.pubkey)
        expect(json_body['pkey']).to eq(wallet.pkey[0, 5])
        expect(json_body['address']).to eq(wallet.address)
      end
    end

    context 'when wallet is created and does not belongs to user' do
      let(:user) { create :user }
      let(:user2) { create :user }
      let(:wallet) { create :wallet, user: user2 }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:show_attributes) { { id: wallet.id } }

      it "renders a not found response" do
        get wallet_url(show_attributes), headers: headers, as: :json

        expect(response).to be_not_found
      end
    end
  end

  describe "POST /create" do
    context 'with valid params' do
      let(:user) { create :user }
      let(:currency) { create :currency, name: 'Bitcoin', code: 'BTC', currency_kind: 'bitcoin' }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:create_attr) { { wallet: { currency_kind: currency.currency_kind } } }
      let(:keys) { { addr: "2847502485943579834adfadhdxvbr", pub_key: '453425245245', priv_key: '249857298475'} }

      before do
        allow(KeyGenerator).to receive(:generate).and_return(keys)
      end

      it 'creates a new wallet' do
        expect {
          post wallets_url,
               params: create_attr, headers: headers, as: :json
        }.to change(Wallet, :count).by(1)
      end

      it 'renders a JSON response with the new wallet' do
        post wallets_url,
             params: create_attr, headers: headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))

        json_body = JSON.parse(body)

        expect(json_body['currency_name']).to eq(currency.name)
        expect(json_body['symbol']).to eq(currency.symbol)
        expect(json_body['pubkey']).to eq(keys[:pub_key])
        expect(json_body['pkey']).to eq(keys[:priv_key][0, 5])
        expect(json_body['address']).to eq(keys[:addr])
        expect(json_body['currency_name']).to eq(currency.name)
      end
    end

    context 'with invalid params' do
      let(:user) { create :user }

      describe 'with unsupported currency' do
        let(:currency) { create :currency, name: 'Bitcoin', code: 'BTC', currency_kind: 'bitcoin' }
        let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:create_attr) { { wallet: { currency_kind: 'euro' } } }

        it 'does not creates a new wallet' do
          expect {
            post wallets_url,
                 params: create_attr, headers: headers, as: :json
          }.to change(Wallet, :count).by(0)
        end

        it 'returns an error message' do
          post wallets_url,
             params: create_attr, headers: headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'with empty currency' do
        let(:currency) { create :currency, name: 'Bitcoin', code: 'BTC', currency_kind: 'bitcoin' }
        let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:create_attr) { { wallet: { currency_kind: '' } } }

        it 'does not creates a new wallet' do
          expect {
            post wallets_url,
                 params: create_attr, headers: headers, as: :json
          }.to change(Wallet, :count).by(0)
        end

        it 'returns an error message' do
          post wallets_url,
             params: create_attr, headers: headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'with integer currency kind' do
        let(:currency) { create :currency, name: 'Bitcoin', code: 'BTC', currency_kind: 'bitcoin' }
        let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:create_attr) { { wallet: { currency_kind: 2342342342 } } }

        # TODO: add filter to validate input

        it 'does not creates a new wallet' do
          expect {
            post wallets_url,
                 params: create_attr, headers: headers, as: :json
          }.to change(Wallet, :count).by(0)
        end

        it 'returns an error message' do
          post wallets_url,
             params: create_attr, headers: headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'with different encoding currency kind' do
        let(:currency) { create :currency, name: 'Bitcoin', code: 'BTC', currency_kind: 'bitcoin' }
        let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:create_attr) { { wallet: { currency_kind: "bitcoin".encode(Encoding::ISO_8859_1) } } }

        # TODO: add filter to validate input

        it 'does not creates a new wallet' do
          expect {
            post wallets_url,
                 params: create_attr, headers: headers, as: :json
          }.to change(Wallet, :count).by(0)
        end

        it 'returns an error message' do
          post wallets_url,
             params: create_attr, headers: headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe "DELETE /destroy" do
    context 'when wallet is created and belongs to user' do
      let(:user) { create :user }
      let(:currency) { create :currency }
      let(:wallet) { create :wallet, user: user, currency: currency }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:destroy_attr) { { id: wallet.id } }

      before do
        wallet
      end

      it 'destroy the requested wallet' do
        expect {
          delete wallet_url(destroy_attr), headers: headers, as: :json
        }.to change(Wallet, :count).by(-1) 
      end
    end

    context 'when wallet is created and does not belongs to user' do
      let(:user) { create :user }
      let(:user2) { create :user }
      let(:currency) { create :currency }
      let(:wallet) { create :wallet, user: user2, currency: currency }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:destroy_attr) { { id: wallet.id } }

      before do
        wallet
      end

      it 'Does not destroy the requested wallet' do
        expect {
          delete wallet_url(destroy_attr), headers: headers, as: :json
        }.to change(Wallet, :count).by(0) 
      end

      it 'Return HTTP not_found' do
        delete wallet_url(destroy_attr), headers: headers, as: :json

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
