require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User with all params' do
    let(:user) { build :user, email: 'test@test.com', password: '12345678' }

    it 'Save user' do
      expect(user.save).to eq(true)
    end

    it 'User is correctly saved' do
      user.save

      last_user = User.find_by_email('test@test.com')

      expect(last_user.email).to eq(user.email)
    end
  end

  describe 'User with missing params' do
    context 'User with missing email' do
      let(:user) { build :user, email: nil, password: '12345678' }

      it "User is not saved and return error" do
        result = user.save

        expect(result).to eq(false)
        expect(user.errors).to_not eq(nil)
        expect(user.errors.full_messages.to_sentence).to eq("Email can't be blank")
      end
    end

    context 'User with missing password' do
      let(:user) { build :user, email: 'test@test.com', password: nil }

      it "User is not saved and return error" do
        result = user.save

        expect(result).to eq(false)
        expect(user.errors).to_not eq(nil)
        expect(user.errors.full_messages.to_sentence).to eq("Password can't be blank")
      end
    end
  end

  describe 'User with malformed params' do
    context 'User with malformed email' do
      let(:user) { build :user, email: 'testtest', password: '12345678' }

      it 'User is not saved and return error' do
        result = user.save

        expect(result).to eq(false)
        expect(user.errors).to_not eq(nil)
        expect(user.errors.full_messages.to_sentence).to eq("Email is invalid")
      end
    end
  end

  describe 'User with duplicated email' do
    let(:user1) { build :user, email: 'test@test.com', password: '12345678' }
    let(:user2) { build :user, email: 'test@test.com', password: '12345678' }

    it 'Saves user 1 but user 2 fails' do
      expect(user1.save).to eq(true)

      user2.save

      expect(user2.errors.full_messages.to_sentence).to eq("Email has already been taken")
    end
  end
end
