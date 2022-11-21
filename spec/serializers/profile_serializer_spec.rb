require 'rails_helper'

RSpec.describe ProfileSerializer do
  describe 'serialize' do
    let(:profile) { create :profile }
    let(:serialized_fields) { ProfileSerializer.new(profile).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:data][:attributes][:first_name]).to eq(profile.first_name)
      expect(serialized_fields[:data][:attributes][:last_name]).to eq(profile.last_name)
      expect(serialized_fields[:data][:attributes][:email]).to eq(profile.email)
      expect(serialized_fields[:data][:attributes][:phone_number_1]).to eq(profile.phone_number_1)
      expect(serialized_fields[:data][:attributes][:phone_number_2]).to eq(profile.phone_number_2)
      expect(serialized_fields[:data][:attributes][:gender]).to eq(profile.gender)
      expect(serialized_fields[:data][:attributes][:birthday]).to eq(profile.birthday.strftime("%Y-%m-%d"))
    end
  end
end