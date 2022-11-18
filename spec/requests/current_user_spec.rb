require 'rails_helper'

RSpec.describe "CurrentUsers", type: :request do
  describe "GET /index" do
    let(:current_user_url) { '/current_user/index' }
    let(:login_url) { '/users/login' }
    let(:user) { create :user, email: 'test@test.com', password: '12345678' }
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

    it "returns http success" do
      token = headers['Authorization']

      get current_user_url, headers: { 'Authorization': token }

      expect(response).to have_http_status(:success)
    end

    it 'get current user' do
      token = headers['Authorization']

      get current_user_url, headers: { 'Authorization': token }

      json_body = JSON.parse(body)

      expect(json_body['id']).to eq(user.id)
      expect(json_body['email']).to eq(user.email)
    end
  end

end
