require 'rails_helper'

RSpec.describe ProfileFactory do
  let(:user) { create :user }

  context 'create' do
    describe 'With valid params' do
      let(:profile_params) do
        {
          first_name: 'Test1',
          last_name: 'Test2',
          phone_number_1: '005491111111111',
          phone_number_2: '005491122222222',
          gender: 'test',
          birthday: '2022-01-31',
        }
      end

      it 'profile is created' do
        created_profile = ProfileFactory.run(profile_params, user)

        profile = Profile.last

        expect(profile.first_name).to eq(profile_params[:first_name])
        expect(profile.last_name).to eq(profile_params[:last_name])
        expect(profile.phone_number_1).to eq(profile_params[:phone_number_1])
        expect(profile.phone_number_2).to eq(profile_params[:phone_number_2])
        expect(profile.gender).to eq(profile_params[:gender])
        expect(profile.birthday).to eq(DateTime.parse(profile_params[:birthday]))
        expect(profile.email).to eq(user.email)
        expect(profile.user).to eq(user)
      end
    end

    describe 'With malformed params' do
      context 'with non complete params' do
        describe 'without first_name' do
          let(:profile_params) do
            {
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31',
            }
          end

          it 'profile is not created' do
            created_profile = ProfileFactory.run(profile_params, user)

            expect(created_profile.errors.full_messages.to_sentence).to eq("First name can't be blank")
            expect(Profile.last).to eq(nil)
          end
        end

        describe 'without last_name' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31',
            }
          end

          it 'profile is not created' do
            created_profile = ProfileFactory.run(profile_params, user)

            expect(created_profile.errors.full_messages.to_sentence).to eq("Last name can't be blank")
            expect(Profile.last).to eq(nil)
          end
        end

        describe 'without phone_number_1' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31',
            }
          end

          it 'profile is not created' do
            created_profile = ProfileFactory.run(profile_params, user)

            expect(created_profile.errors.full_messages.to_sentence).to eq("Phone number 1 can't be blank and Phone number 1 is too short (minimum is 10 characters)")
            expect(Profile.last).to eq(nil)
          end
        end

        describe 'without phone_number_2' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              gender: 'test',
              birthday: '2022-01-31',
            }
          end

          it 'profile is created' do
            created_profile = ProfileFactory.run(profile_params, user)

            profile = Profile.last

            expect(profile.first_name).to eq(profile_params[:first_name])
            expect(profile.last_name).to eq(profile_params[:last_name])
            expect(profile.phone_number_1).to eq(profile_params[:phone_number_1])
            expect(profile.phone_number_2).to eq(nil)
            expect(profile.gender).to eq(profile_params[:gender])
            expect(profile.birthday).to eq(DateTime.parse(profile_params[:birthday]))
            expect(profile.email).to eq(user.email)
            expect(profile.user).to eq(user)
          end
        end

        describe 'without gender' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              birthday: '2022-01-31',
            }
          end

          it 'profile is created' do
            created_profile = ProfileFactory.run(profile_params, user)

            profile = Profile.last

            expect(profile.first_name).to eq(profile_params[:first_name])
            expect(profile.last_name).to eq(profile_params[:last_name])
            expect(profile.phone_number_1).to eq(profile_params[:phone_number_1])
            expect(profile.phone_number_2).to eq(profile_params[:phone_number_2])
            expect(profile.gender).to eq(nil)
            expect(profile.birthday).to eq(DateTime.parse(profile_params[:birthday]))
            expect(profile.email).to eq(user.email)
            expect(profile.user).to eq(user)
          end
        end

        describe 'without birthday' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
            }
          end

          it 'profile is created' do
            created_profile = ProfileFactory.run(profile_params, user)

            profile = Profile.last

            expect(profile.first_name).to eq(profile_params[:first_name])
            expect(profile.last_name).to eq(profile_params[:last_name])
            expect(profile.phone_number_1).to eq(profile_params[:phone_number_1])
            expect(profile.phone_number_2).to eq(profile_params[:phone_number_2])
            expect(profile.gender).to eq(profile_params[:gender])
            expect(profile.birthday).to eq(nil)
            expect(profile.email).to eq(user.email)
            expect(profile.user).to eq(user)
          end
        end

        describe 'without gender' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              birthday: '2022-01-31',
            }
          end

          it 'profile is created' do
            created_profile = ProfileFactory.run(profile_params, user)

            profile = Profile.last

            expect(profile.first_name).to eq(profile_params[:first_name])
            expect(profile.last_name).to eq(profile_params[:last_name])
            expect(profile.phone_number_1).to eq(profile_params[:phone_number_1])
            expect(profile.phone_number_2).to eq(profile_params[:phone_number_2])
            expect(profile.birthday).to eq(DateTime.parse(profile_params[:birthday]))
            expect(profile.email).to eq(user.email)
            expect(profile.user).to eq(user)
          end
        end

        describe 'without user' do
          let(:profile_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-01-31',
            }
          end

          it 'profile is not created' do
            created_profile = ProfileFactory.run(profile_params, nil)

            expect(created_profile).to eq(nil)
          end
        end
      end
    end
  end

  context 'update' do
    describe 'With valid params' do
      let(:profile) { create :profile }
      let(:update_params) do
        {
          first_name: 'Test1',
          last_name: 'Test2',
          phone_number_1: '005491111111111',
          phone_number_2: '005491122222222',
          gender: 'test',
          birthday: '2022-02-20',
        }
      end

      it 'profile is updated' do
        expect(profile.first_name).not_to eq(update_params[:first_name])
        expect(profile.last_name).not_to eq(update_params[:last_name])
        expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
        expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
        expect(profile.gender).not_to eq(update_params[:gender])
        expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

        updated_profile = ProfileFactory.run(update_params, profile.user)

        expect(updated_profile.first_name).to eq(update_params[:first_name])
        expect(updated_profile.last_name).to eq(update_params[:last_name])
        expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
        expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
        expect(updated_profile.gender).to eq(update_params[:gender])
        expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
      end
    end

    describe 'With invalid params' do
      context 'with missing params' do
        describe 'with missing first_name' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is not updated except for first_name' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(profile.first_name)
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing last_name' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for last_name' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(profile.last_name)
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing phone_number_1' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for phone_number_1' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(profile.phone_number_1)
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing phone_number_2' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for phone_number_2' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(profile.phone_number_2)
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing gender' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for gender' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(profile.gender)
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing birthday' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
            }
          end

          it 'profile is updated except for birthday' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(profile.birthday)
          end
        end
      end

      context 'with empty params' do
        describe 'with missing first_name' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: '',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is not updated except for first_name' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(profile.first_name)
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing last_name' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: '',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for last_name' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(profile.last_name)
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing phone_number_1' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for phone_number_1' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(profile.phone_number_1)
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing phone_number_2' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '',
              gender: 'test',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for phone_number_2' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(profile.phone_number_2)
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing gender' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: '',
              birthday: '2022-02-20',
            }
          end

          it 'profile is updated except for gender' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])
            expect(profile.birthday).not_to eq(DateTime.parse(update_params[:birthday]))

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(profile.gender)
            expect(updated_profile.birthday).to eq(DateTime.parse(update_params[:birthday]))
          end
        end

        describe 'with missing birthday' do
          let(:profile) { create :profile }
          let(:update_params) do
            {
              first_name: 'Test1',
              last_name: 'Test2',
              phone_number_1: '005491111111111',
              phone_number_2: '005491122222222',
              gender: 'test',
              birthday: ''
            }
          end

          it 'profile is updated except for birthday' do
            expect(profile.first_name).not_to eq(update_params[:first_name])
            expect(profile.last_name).not_to eq(update_params[:last_name])
            expect(profile.phone_number_1).not_to eq(update_params[:phone_number_1])
            expect(profile.phone_number_2).not_to eq(update_params[:phone_number_2])
            expect(profile.gender).not_to eq(update_params[:gender])

            updated_profile = ProfileFactory.run(update_params, profile.user)

            expect(updated_profile.first_name).to eq(update_params[:first_name])
            expect(updated_profile.last_name).to eq(update_params[:last_name])
            expect(updated_profile.phone_number_1).to eq(update_params[:phone_number_1])
            expect(updated_profile.phone_number_2).to eq(update_params[:phone_number_2])
            expect(updated_profile.gender).to eq(update_params[:gender])
            expect(updated_profile.birthday).to eq(profile.birthday)
          end
        end
      end
    end
  end
end