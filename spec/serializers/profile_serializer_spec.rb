require 'rails_helper'

RSpec.describe ProfileSerializer do
  describe 'serialize' do
    let(:profile) { create :profile }
    let(:serialized_fields) { ProfileSerializer.new(profile).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:first_name]).to eq(profile.first_name)
      expect(serialized_fields[:last_name]).to eq(profile.last_name)
      expect(serialized_fields[:email]).to eq(profile.email)
      expect(serialized_fields[:phone_number_1]).to eq(profile.phone_number_1)
      expect(serialized_fields[:phone_number_2]).to eq(profile.phone_number_2)
      expect(serialized_fields[:gender]).to eq(profile.gender)
      expect(serialized_fields[:birthday]).to eq(profile.birthday.strftime("%Y-%m-%d"))
    end
  end
end