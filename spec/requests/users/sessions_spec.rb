require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /users/login' do
    let(:login_url) { '/users/login' }
    let(:user) { create :user, email: 'test@test.com', password: '12345678'}

    describe 'correct login info' do
      let(:login_payload) do
        {
          user: {
            email: user.email,
            password: '12345678'
          }
        }
      end

      it 'get_success code' do
        post login_url, params: login_payload

        expect(response).to have_http_status(:success)
      end

      it 'get user data' do
        post login_url, params: login_payload

        json_body = JSON.parse(body)

        expect(json_body['data']['email']).to eq(user.email)
        expect(json_body['data']['id']).to eq(user.id)
        expect(json_body['data']['created_at']).not_to eq(nil)
      end

      it 'get authorization token' do
        post login_url, params: login_payload

        expect(headers['Content-Type']).to include('application/json;')
        expect(headers['Authorization']).to include('Bearer')
      end
    end

    describe 'incorrect login info' do
      let(:login_payload) do
        {
          user: {
            email: user.email,
            password: '123456789'
          }
        }
      end

      it 'get success code' do
        post login_url, params: login_payload

        expect(response).to have_http_status(:success)
      end

      it 'do not get user data' do
        post login_url, params: login_payload

        json_body = JSON.parse(body)

        expect(json_body['data']['id']).to eq(nil)
        expect(json_body['data']['created_at']).to eq(nil)
      end

      it 'do not get authorization token' do
        post login_url, params: login_payload

        expect(headers['Content-Type']).to include('application/json;')
        expect(headers['Authorization']).to eq(nil)
      end
    end
  end

  describe 'DELETE /users/logout' do
    let(:login_url) { '/users/login' }
    let(:logout_url) { '/users/logout' }
    let(:user) { create :user, email: 'test@test.com', password: '12345678'}

    context 'already logged in user' do
      let(:login_payload) do
        {
          user: {
            email: user.email,
            password: '12345678'
          }
        }
      end

      before do
        post login_url, params: login_payload
      end

      it 'get success code and log out message ' do
        token = headers['Authorization']

        delete logout_url, headers: { 'Authorization': token }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(body)['message']).to eq('Logged out successfully')
      end
    end

    context 'user not logged in' do
      context 'session not found' do
        it 'get unauthorized code and log out message ' do
          token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkNjBlYmI1NC0wMDU4LTQ0OTYtOTM4Yi00MDRkNzA4NTY3YmUiLCJzY3AiOiJ1c2VyIiwiYXVkIjpudWxsLCJpYXQiOjE2Njg3NDkxNDQsImV4cCI6MTY3MDA0NTE0NCwianRpIjoiNDg4ZjlmYzAtZjY5Ni00ODRmLWFjMzktMzRmNDZkYTk5NDJiIn0.5OdYK8g5WFclJRwr_xldQs_qus_u0VAphBLbmHcZpVY'
  
          delete logout_url, headers: { 'Authorization': token }
  
          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(body)['message']).to eq("Couldn't find an active session.")
        end

        context 'token not sent in request' do
          it 'get unauthorized code and log out message' do
            delete logout_url
      
            expect(response).to have_http_status(:unauthorized)
            expect(JSON.parse(body)['message']).to eq("Couldn't find an active session.")
          end
        end
      end
    end
  end
end