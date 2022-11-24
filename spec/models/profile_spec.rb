require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create :user }

  describe 'Profile with all params' do
    let(:profile) { build :profile, first_name: 'Test1', last_name: 'Test2', email: 'test@test.com', phone_number_1: "005879823492", phone_number_2: '005491122222222', birthday: DateTime.parse('2022-01-31'), gender: "test", user: user }

    it 'Save Profile' do
      expect(profile.save).to eq(true)
    end

    it 'Profile is correctly saved' do
      profile.save

      last_profile = Profile.find_by_email('test@test.com')

      expect(last_profile.email).to eq(profile.email)
      expect(last_profile.first_name).to eq(profile.first_name)
      expect(last_profile.last_name).to eq(profile.last_name)
    end
  end

  describe 'Profile with missing params' do
    context 'Profile with missing first name' do
      let(:profile) { build :profile, first_name: nil, last_name: 'Test2', email: 'test@test.com', phone_number_1: "005879823492", phone_number_2: '005491122222222', birthday: DateTime.parse('2022-01-31'), gender: "test", user: user}

      it "Profile is not saved and return error" do
        result = profile.save

        expect(result).to eq(false)
        expect(profile.errors).to_not eq(nil)
        expect(profile.errors.full_messages.to_sentence).to eq("First name can't be blank")
      end
    end

    context 'Profile with missing last name' do
      let(:profile) { build :profile, first_name: "Test1", last_name: nil, email: 'test@test.com', phone_number_1: "005879823492", phone_number_2: '005491122222222', birthday: DateTime.parse('2022-01-31'), gender: "test", user: user }

      it "Profile is not saved and return error" do
        result = profile.save

        expect(result).to eq(false)
        expect(profile.errors).to_not eq(nil)
        expect(profile.errors.full_messages.to_sentence).to eq("Last name can't be blank")
      end
    end

    context 'Profile with missing email' do
      let(:profile) { build :profile, first_name: "Test1", last_name: 'Test2', email: nil, phone_number_1: "005879823492", phone_number_2: '005491122222222', birthday: DateTime.parse('2022-01-31'), gender: "test", user: user }

      it "Profile is not saved and return error" do
        result = profile.save

        expect(result).to eq(false)
        expect(profile.errors).to_not eq(nil)
        expect(profile.errors.full_messages.to_sentence).to eq("Email is invalid and Email can't be blank")
      end
    end

    context 'Profile with missing phone_number_1' do
      let(:profile) { build :profile, first_name: "Test1", last_name: 'Test2', email: 'test@test.com', phone_number_1: '', phone_number_2: '005491122222222', birthday: DateTime.parse('2022-01-31'), gender: "test", user: user }

      it "Profile is not saved and return error" do
        result = profile.save

        expect(result).to eq(false)
        expect(profile.errors).to_not eq(nil)
        expect(profile.errors.full_messages.to_sentence).to eq("Phone number 1 can't be blank and Phone number 1 is too short (minimum is 10 characters)")
      end
    end
  end

  describe 'Profile with malformed params' do
    context 'Profile with malformed email' do
      let(:profile) { build :profile, first_name: 'Test1', last_name: 'Test2', email: 'testtest', phone_number_1: "005879823492", user: user }

      it 'Profile is not saved and return error' do
        result = profile.save

        expect(result).to eq(false)
        expect(profile.errors).to_not eq(nil)
        expect(profile.errors.full_messages.to_sentence).to eq("Email is invalid")
      end
    end
  end

  describe 'Profile with duplicated email' do
    let(:user2) { create :user }
    let(:profile1) { build :profile, first_name: 'Test1', last_name: 'Test2', email: 'test@test.com', phone_number_1: "005879823492", user: user }
    let(:profile2) { build :profile, first_name: 'Test2', last_name: 'Test3', email: 'test@test.com', phone_number_1: "005879823493", user: user2 }

    it 'Saves profile 1 but profile 2 fails' do
      expect(profile1.save).to eq(true)

      profile2.save

      expect(profile2.errors.full_messages.to_sentence).to eq("Email has already been taken")
    end
  end

  describe 'Profile with duplicated phone number 1' do
    let(:user2) { create :user }
    let(:profile1) { build :profile, first_name: 'Test1', last_name: 'Test2', email: 'test1@test1.com', phone_number_1: "005879823493", user: user }
    let(:profile2) { build :profile, first_name: 'Test2', last_name: 'Test3', email: 'test2@test2.com', phone_number_1: "005879823493", user: user2 }

    it 'Saves profile 1 but profile 2 fails' do
      expect(profile1.save).to eq(true)

      profile2.save

      expect(profile2.errors.full_messages.to_sentence).to eq("Phone number 1 has already been taken")
    end
  end

  describe 'methods' do
    context '#make_available' do
      let(:profile) { create :profile }

      it 'sets available to true' do
        profile.make_available

        expect(profile.available).to eq(true)
      end
    end

    context '#make_unavailable' do
      let(:profile) { create :profile }

      it 'sets available to true' do
        profile.make_unavailable

        expect(profile.available).to eq(false)
      end
    end

    context '#make_soft_delete' do
      let(:profile) { create :profile }

      it 'sets deleted to true' do
        profile.make_soft_delete

        expect(profile.deleted).to eq(true)
      end
    end

    context '#make_soft_undelete' do
      let(:profile) { create :profile }

      it 'sets deleted to true' do
        profile.make_soft_undelete

        expect(profile.deleted).to eq(false)
      end
    end
  end
end
