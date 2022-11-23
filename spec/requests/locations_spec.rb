require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/locations", type: :request do
  let(:valid_headers) { {} }
  describe "GET /show" do
    let(:show_location_url) { '/location' }

    context 'with created location' do
      let(:geolocation) { build :geolocation }
      let(:location) { create :location, geolocation: geolocation }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, location.user) }

      it 'renders a successful response' do
        get show_location_url, headers: headers, as: :json

        expect(response).to be_successful
      end

      it 'renders location data' do
        get show_location_url, headers: headers, as: :json

        parsed_response = JSON.parse(body)

        expect(parsed_response['location']['address_1']).to eq(location.address_1)
        expect(parsed_response['location']['address_2']).to eq(location.address_2)
        expect(parsed_response['location']['country']).to eq(location.country)
        expect(parsed_response['location']['state']).to eq(location.state)
        expect(parsed_response['location']['zipcode']).to eq(location.zipcode)
        expect(parsed_response['location']['geolocation']['latitude']).to eq(location.geolocation.latitude)
        expect(parsed_response['location']['geolocation']['longitude']).to eq(location.geolocation.longitude)
      end
    end

    context 'without created profile' do
      let(:user) { create :user }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }

      it 'renders a successful response' do
        get show_location_url, headers: headers, as: :json

        expect(response).to be_not_found
      end
    end
  end

  describe "POST /create" do
    let(:create_location_url) { "/locations" }
    let(:valid_attributes) do
      {
        address_1: 'Test1',
        address_2: 'Test2',
        country: 'Venezuela',
        country_code: 'VE',
        state: 'Aragua',
        state_code: 'AR',
        zipcode: 11111,
        geolocation: {
          latitude: '12.234',
          longitude: '56.678'
        }
      }
    end

    context 'with valid parameters' do
      let(:user) { create :user, email: 'test@test.com', password: '12345678'}
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }

      it 'creates a new Location' do
        expect {
          post create_location_url,
               params: { location: valid_attributes }, headers: headers, as: :json
        }.to change(Location, :count).by(1)
      end

      it 'renders a JSON response with the new profile' do
        post create_location_url,
             params: { location: valid_attributes }, headers: headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context 'with invalid parameters' do
      describe 'with missing params' do
        context 'without address_1' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_2: 'Test2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'does not create a new Location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including("application/json"))
          end
        end

        context 'without address_2' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'does not create a new Location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without country' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'does not create a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without country_code' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country: 'Venezuela',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'does not creates a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without state' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country: 'Venezuela',
              country_code: 'VE',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'creates a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without state_code' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'creates a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without zipcode' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              geolocation: {
                latitude: '12.234',
                longitude: '56.678'
              }
            }
          end

          it 'creates a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without geolocation latitude' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                longitude: '56.678'
              }
            }
          end

          it 'creates a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end
        
        context 'without geolocation longitude' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              address_1: 'Test1',
              address_2: 'Test2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 11111,
              geolocation: {
                latitude: '12.234'
              }
            }
          end

          it 'creates a new location' do
            expect {
              post create_location_url,
                   params: { location: invalid_attributes }, headers: headers, as: :json
            }.to change(Location, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new location' do
            post create_location_url,
                 params: { location: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end
      end
    end



    # context "with valid parameters" do
    #   it "creates a new Location" do
    #     expect {
    #       post locations_url,
    #            params: { location: valid_attributes }, headers: valid_headers, as: :json
    #     }.to change(Location, :count).by(1)
    #   end

    #   it "renders a JSON response with the new location" do
    #     post locations_url,
    #          params: { location: valid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:created)
    #     expect(response.content_type).to match(a_string_including("application/json"))
    #   end
    # end

    # context "with invalid parameters" do
    #   it "does not create a new Location" do
    #     expect {
    #       post locations_url,
    #            params: { location: invalid_attributes }, as: :json
    #     }.to change(Location, :count).by(0)
    #   end

    #   it "renders a JSON response with errors for the new location" do
    #     post locations_url,
    #          params: { location: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to match(a_string_including("application/json"))
    #   end
    # end
  end
end
