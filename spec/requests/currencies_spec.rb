require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/currencies", type: :request do
  describe "GET /index" do
    let(:user) { create :user }
    let(:currency_1) { create :currency }
    let(:currency_2) { create :currency }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }

    before do
      currency_1
      currency_2
    end

    it "renders a successful response" do
      get currencies_url, headers: auth_headers, as: :json

      expect(response).to be_successful
    end

    it 'returns an array of available currencies' do
      get currencies_url, headers: auth_headers, as: :json

      json_body = JSON.parse(body)

      expect(json_body[0].symbolize_keys).to eq({ name: currency_1.name, code: currency_1.code, symbol: currency_1.symbol })
      expect(json_body[1].symbolize_keys).to eq({ name: currency_2.name, code: currency_2.code, symbol: currency_2.symbol })
    end
  end

  describe "GET /show" do
    let(:user) { create :user }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
    let(:currency) { create :currency }
    let(:show_params) { { id: currency.id } }

    it 'renders a successful response' do
      get currency_url(show_params), headers: auth_headers, as: :json

      expect(response).to be_successful
    end

    it 'returns a serialized currency object' do
      get currency_url(show_params), headers: auth_headers, as: :json

      json_body = JSON.parse(body).deep_symbolize_keys

      expect(json_body[:name]).to eq(currency.name)
      expect(json_body[:code]).to eq(currency.code)
      expect(json_body[:symbol]).to eq(currency.symbol)
    end
  end

  describe 'POST /create' do
    context 'with_valid_params' do
      let(:user) { create :admin }
      let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:valid_attributes) { { name: "US Dollar", code: "USD", symbol: '$' } }

      it 'creates a new Currency' do
        expect {
          post currencies_url,
               params: { currency: valid_attributes }, headers: auth_headers, as: :json
        }.to change(Currency, :count).by(1)
      end

      it 'renders a JSON response with the new currency' do
        post currencies_url,
             params: { currency: valid_attributes }, headers: auth_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))

        json_body = JSON.parse(body).deep_symbolize_keys

        expect(json_body[:currency][:name]).to eq('US Dollar')
        expect(json_body[:currency][:code]).to eq('USD')
        expect(json_body[:currency][:symbol]).to eq('$')
      end
    end

    context 'with invalid params' do
      describe 'with missing params' do
        let(:user) { create :admin }
        let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:invalid_attributes) { { code: "USD", symbol: '$' } }

        it 'creates a new Currency' do
          expect {
            post currencies_url,
                 params: { currency: invalid_attributes }, headers: auth_headers, as: :json
          }.to change(Currency, :count).by(0)
        end

        it 'renders a JSON response with the new currency' do
          post currencies_url,
               params: { currency: invalid_attributes }, headers: auth_headers, as: :json

          expect(response).to have_http_status(422)
          # TODO: add expectation for body
        end
      end

      describe 'with malformed attributes' do
        let(:user) { create :admin }
        let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:invalid_attributes) { { name: 'US Dollar', test: "USD" , symbol: '$' } }

        it 'creates a new Currency' do
          expect {
            post currencies_url,
                 params: { currency: invalid_attributes }, headers: auth_headers, as: :json
          }.to change(Currency, :count).by(0)
        end

        it 'renders a JSON response with the new currency' do
          post currencies_url,
               params: { currency: invalid_attributes }, headers: auth_headers, as: :json

          expect(response).to have_http_status(422)
          # TODO: add expectation for body
        end
      end
    end
  end

  describe 'PATCH /update' do
    context 'with_valid_params' do
      let(:user) { create :admin }
      let(:currency) { create :currency }
      let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
      let(:valid_attributes) { { name: "US Dollar", code: "USD", symbol: '$' } }

      it 'renders a JSON response with the new currency' do
        patch currency_url(currency),
             params: { currency: valid_attributes }, headers: auth_headers, as: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))

        json_body = JSON.parse(body).deep_symbolize_keys

        expect(json_body[:currency][:name]).to eq('US Dollar')
        expect(json_body[:currency][:code]).to eq('USD')
        expect(json_body[:currency][:symbol]).to eq('$')

        currency.reload

        expect(currency.name).to eq('US Dollar')
        expect(currency.code).to eq('USD')
        expect(currency.symbol).to eq('$')
      end
    end

    context 'with different params' do
      describe 'with missing params' do
        let(:user) { create :admin }
        let(:currency) { create :currency }
        let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:invalid_attributes) { { code: "USD", symbol: '$' } }

        it 'renders a JSON response with the new currency' do
          patch currency_url(currency),
               params: { currency: invalid_attributes }, headers: auth_headers, as: :json

          expect(response).to have_http_status(200)
          # TODO: add expectation for body
          
          json_body = JSON.parse(body).deep_symbolize_keys

          expect(json_body[:currency][:code]).to eq('USD')
          expect(json_body[:currency][:symbol]).to eq('$')

          currency.reload

          expect(currency.code).to eq('USD')
          expect(currency.symbol).to eq('$')
        end
      end

      describe 'with malformed attributes' do
        let(:user) { create :admin }
        let(:currency) { create :currency }
        let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:invalid_attributes) { { name: 'US Dollar', test: "USD" , symbol: '$' } }

        it 'renders a JSON response with the new currency' do
          patch currency_url(currency),
               params: { currency: invalid_attributes }, headers: auth_headers, as: :json

          expect(response).to have_http_status(200)
          # TODO: add expectation for body

          json_body = JSON.parse(body).deep_symbolize_keys

          expect(json_body[:currency][:name]).to eq('US Dollar')
          expect(json_body[:currency][:symbol]).to eq('$')

          currency.reload

          expect(currency.name).to eq('US Dollar')
          expect(currency.symbol).to eq('$')
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:user) { create :admin }
    let(:currency) { create :currency }
    let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
    let(:destroy_attribute) { { id: currency.id } }

    before do
      currency
    end

    it 'destroys the requested currency' do
      expect {
        delete currency_url(currency), headers: auth_headers, as: :json
      }.to change(Currency, :count).by(-1)
    end
  end
end
