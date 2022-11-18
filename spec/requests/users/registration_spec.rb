require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /users/signup' do
    let(:json_headers) { { 'CONTENT_TYPE' => 'application/json' } }
    let(:signup_url) { '/users/signup' }

    context 'with complete params' do
      let(:registration_payload) do
        {
          user: {
            email: 'test@test.com',
            password: '12345678',
            password_confirmation: '12345678'
          }
        }
      end

      it 'returns http success' do
        post signup_url, params: registration_payload

        expect(response).to have_http_status(:success)
      end

      it 'returns success message' do
        post signup_url, params: registration_payload

        json_body = JSON.parse(body)

        expect(json_body['status']['message']).to eq('Signed up successfully.')
        expect(json_body['data']['email']).to eq(registration_payload[:user][:email])
      end 
    end

    context 'with malformed params' do
      describe 'with missing email' do
        let(:registration_payload) do
          {
            user: {
              email: '',
              password: '12345678',
              password_confirmation: '12345678'
            }
          }
        end

        it 'returns http unprocessable_entity' do
          post signup_url, params: registration_payload
  
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error message' do
          post signup_url, params: registration_payload
  
          json_body = JSON.parse(body)
  
          expect(json_body['status']['message']).to eq("User couldn't be created successfully. Email can't be blank")
        end
      end

      describe 'with malformed email' do
        let(:registration_payload) do
          {
            user: {
              email: 'testtest',
              password: '12345678',
              password_confirmation: '12345678'
            }
          }
        end

        it 'returns http unprocessable_entity' do
          post signup_url, params: registration_payload
  
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error message' do
          post signup_url, params: registration_payload
  
          json_body = JSON.parse(body)
  
          expect(json_body['status']['message']).to eq("User couldn't be created successfully. Email is invalid")
        end
      end

      describe 'with missing password' do
        let(:registration_payload) do
          {
            user: {
              email: 'test@test.com',
              password: '',
              password_confirmation: '12345678'
            }
          }
        end

        it 'returns http unprocessable_entity' do
          post signup_url, params: registration_payload
  
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error message' do
          post signup_url, params: registration_payload
  
          json_body = JSON.parse(body)
  
          expect(json_body['status']['message']).to eq("User couldn't be created successfully. Password can't be blank and Password confirmation doesn't match Password")
        end
      end

      describe 'with missing password confirmation' do
        let(:registration_payload) do
          {
            user: {
              email: 'test@test.com',
              password: '12345678',
              password_confirmation: ''
            }
          }
        end

        it 'returns http unprocessable_entity' do
          post signup_url, params: registration_payload
  
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error message' do
          post signup_url, params: registration_payload
  
          json_body = JSON.parse(body)
  
          expect(json_body['status']['message']).to eq("User couldn't be created successfully. Password confirmation doesn't match Password")
        end
      end
    end
  end
end