require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/profiles", type: :request do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {}
  }

  # describe "GET /index" do
  #   it "renders a successful response" do
  #     Profile.create! valid_attributes
  #     get profiles_url, headers: valid_headers, as: :json
  #     expect(response).to be_successful
  #   end
  # end

  describe "GET /show" do
    let(:show_profile_url) { '/profile' }
    
    context 'with created profile' do
      let(:profile) { create :profile }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }

      it 'renders a successful response' do
        get show_profile_url, headers: headers, as: :json

        expect(response).to be_successful
      end

      it 'renders profile data' do
        get show_profile_url, headers: headers, as: :json

        parsed_response = JSON.parse(body)

        expect(parsed_response['profile']['first_name']).to eq(profile.first_name)
        expect(parsed_response['profile']['last_name']).to eq(profile.last_name)
        expect(parsed_response['profile']['email']).to eq(profile.email)
        expect(parsed_response['profile']['phone_number_1']).to eq(profile.phone_number_1)
        expect(parsed_response['profile']['phone_number_2']).to eq(profile.phone_number_2)
        expect(parsed_response['profile']['gender']).to eq(profile.gender)
        expect(parsed_response['profile']['birthday']).to eq(profile.birthday.strftime("%Y-%m-%d"))
      end
    end

    context 'without created profile' do
      let(:user) { create :user }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }

      it 'renders a successful response' do
        get show_profile_url, headers: headers, as: :json

        expect(response).to be_successful
      end
    end
  end

  describe "POST /create" do
    let(:profile_url) { "/profiles" }
    let(:valid_attributes) do
      {
        first_name: 'Test1',
        last_name: 'Test2',
        phone_number_1: '005491111111111',
        phone_number_2: '005491122222222',
        gender: 'test',
        birthday: '2022-01-31'
      }
    end

    context 'with valid parameters' do
      let(:user) { create :user, email: 'test@test.com', password: '12345678'}
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }

      it 'creates a new Profile' do
        expect {
          post profile_url,
               params: { profile: valid_attributes }, headers: headers, as: :json
        }.to change(Profile, :count).by(1)
      end

      it 'renders a JSON response with the new profile' do
        post profile_url,
             params: { profile: valid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context 'with invalid parameters' do
      describe 'with missing params' do
        context 'without first_name' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          it 'does not create a new Profile' do
            expect {
              post profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new profile' do
            post profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including("application/json"))
          end
        end

        context 'without last_name' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          it 'does not create a new Profile' do
            expect {
              post profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new profile' do
            post profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without phone_number_1' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          it 'does not create a new Profile' do
            expect {
              post profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response with errors for the new profile' do
            post profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without phone_number_2' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:non_complete_attrs) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          it 'creates a new Profile' do
            expect {
              post profile_url,
                   params: { profile: non_complete_attrs }, headers: headers, as: :json
            }.to change(Profile, :count).by(1)
          end
    
          it 'renders a JSON response with the new profile' do
            post profile_url,
                 params: { profile: non_complete_attrs }, headers: headers, as: :json
            expect(response).to have_http_status(:created)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without gender' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:non_complete_attrs) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              birthday: '2022-01-31'
            }
          end

          it 'creates a new Profile' do
            expect {
              post profile_url,
                   params: { profile: non_complete_attrs }, headers: headers, as: :json
            }.to change(Profile, :count).by(1)
          end
    
          it 'renders a JSON response with the new profile' do
            post profile_url,
                 params: { profile: non_complete_attrs }, headers: headers, as: :json
            expect(response).to have_http_status(:created)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'without birthday' do
          let(:user) { create :user }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, user) }
          let(:non_complete_attrs) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
            }
          end

          it 'creates a new Profile' do
            expect {
              post profile_url,
                   params: { profile: non_complete_attrs }, headers: headers, as: :json
            }.to change(Profile, :count).by(1)
          end
    
          it 'renders a JSON response with the new profile' do
            post profile_url,
                 params: { profile: non_complete_attrs }, headers: headers, as: :json
            expect(response).to have_http_status(:created)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end
      end
    end

    context 'without authentication' do
      let(:user) { create :user, email: 'test@test.com', password: '12345678'}
      let(:valid_attributes) do
        {
          first_name: 'Test1',
          last_name: 'Test2',
          phone_number_1: '005491111111111',
          phone_number_2: '005491122222222',
          gender: 'test',
          birthday: '2022-01-31'
        }
      end

      it 'renders a JSON error unauthorized' do
        post profile_url,
             params: { profile: valid_attributes }, headers: {}, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    let(:profile_url) { "/profiles" }
    let(:valid_attributes) do
      {
        first_name: 'Test1',
        last_name: 'Test2',
        phone_number_1: '005491111111111',
        phone_number_2: '005491122222222',
        gender: 'test',
        birthday: '2022-01-31'
      }
    end

    context 'with valid parameters' do
      let(:profile) { create :profile }
      let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }

      before do
        profile
      end

      it 'updates the existing Profile' do
        expect {
          patch profile_url,
               params: { profile: valid_attributes }, headers: headers, as: :json
        }.to change(Profile, :count).by(0)
      end

      it 'renders a JSON response with the updated profile' do
        patch profile_url,
             params: { profile: valid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it 'updates profile' do
        patch profile_url,
             params: { profile: valid_attributes }, headers: headers, as: :json

        updated_profile = Profile.find_by_id(profile.id)

        expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
        expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
        expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
        expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
        expect(updated_profile.gender).to eq(valid_attributes[:gender])
        expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
      end
    end

    context 'with invalid parameters' do
      describe 'with missing params' do
        context 'without first_name' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including("application/json"))
          end

          it 'updates profile' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(profile.first_name)
            expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
        end

        context 'without last_name' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including('application/json'))
          end

          it 'updates profile' do
            patch profile_url,
            params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
            expect(updated_profile.last_name).to eq(profile.last_name)
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
        end

        context 'without phone_number_1' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including('application/json'))
          end

          it 'updates profile' do
            patch profile_url,
            params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
            expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
            expect(updated_profile.phone_number_1).to eq(profile.phone_number_1)
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
        end

        context 'without phone_number_2' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:non_complete_attrs) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: non_complete_attrs }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: non_complete_attrs }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including('application/json'))
          end

          it 'updates profile' do
            patch profile_url,
            params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
            expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(profile.phone_number_2)
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
        end

        context 'without gender' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:non_complete_attrs) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: non_complete_attrs }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: non_complete_attrs }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including('application/json'))
          end

          it 'updates profile' do
            patch profile_url,
            params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
            expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(profile.gender)
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
        end

        context 'without birthday' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:non_complete_attrs) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: non_complete_attrs }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: non_complete_attrs }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including('application/json'))
          end

          it 'updates profile' do
            patch profile_url,
            params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
            expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(profile.birthday)
          end
        end
      end

      describe 'with malformed params' do
        context 'with empty first_name' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              first_name: '',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including("application/json"))
          end

          it 'updates profile' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(profile.first_name)
            expect(updated_profile.last_name).to eq(valid_attributes[:last_name])
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
        end

        context 'with empty last_name' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              last_name: '',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does not update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)

            updated_profile = Profile.find_by_id(profile.id)
    
            expect(updated_profile.first_name).to eq(valid_attributes[:first_name])
            expect(updated_profile.last_name).to eq(profile.last_name)
            expect(updated_profile.phone_number_1).to eq(valid_attributes[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(valid_attributes[:phone_number_2])
            expect(updated_profile.gender).to eq(valid_attributes[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(valid_attributes[:birthday]))
          end
    
          it 'renders a JSON unprocessable entity response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including("application/json"))
          end
        end

        context 'with short phone_number_1' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '0054911',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)
          end
    
          it 'renders a JSON response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including("application/json"))
          end

          it 'updates profile' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json

            updated_profile = Profile.find_by_id(profile.id)

            expect(updated_profile.first_name).to eq(profile.first_name)
            expect(updated_profile.last_name).to eq(profile.last_name)
            expect(updated_profile.phone_number_1).to eq(profile.phone_number_1)
            expect(updated_profile.phone_number_2).to eq(profile.phone_number_2)
            expect(updated_profile.gender).to eq(profile.gender)
            expect(updated_profile.birthday).to eq(profile.birthday)
          end
        end

        context 'with short phone_number_2' do
          let(:profile) { create :profile }
          let(:headers) { Devise::JWT::TestHelpers.auth_headers(valid_headers, profile.user) }
          let(:invalid_attributes) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '0054911',
              gender: 'test',
              birthday: '2022-01-31'
            }
          end

          before do
            profile
          end

          it 'does not update the Profile' do
            expect {
              patch profile_url,
                   params: { profile: invalid_attributes }, headers: headers, as: :json
            }.to change(Profile, :count).by(0)

            updated_profile = Profile.find_by_id(profile.id)

            expect(updated_profile.first_name).to eq(profile.first_name)
            expect(updated_profile.last_name).to eq(profile.last_name)
            expect(updated_profile.phone_number_1).to eq(profile.phone_number_1)
            expect(updated_profile.phone_number_2).to eq(profile.phone_number_2)
            expect(updated_profile.gender).to eq(profile.gender)
            expect(updated_profile.birthday).to eq(profile.birthday)
          end
    
          it 'renders a JSON unprocessable entity response without errors' do
            patch profile_url,
                 params: { profile: invalid_attributes }, headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including("application/json"))
          end
        end
      end
    end

    context 'without authentication' do
      let(:user) { create :user, email: 'test@test.com', password: '12345678'}
      let(:valid_attributes) do
        {
          first_name: 'Test1',
          last_name: 'Test2',
          phone_number_1: '005491111111111',
          phone_number_2: '005491122222222',
          gender: 'test',
          birthday: '2022-01-31'
        }
      end

      it 'renders a JSON error unauthorized' do
        patch profile_url,
             params: { profile: valid_attributes }, headers: {}, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
