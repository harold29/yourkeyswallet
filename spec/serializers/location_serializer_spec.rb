require 'rails_helper'

RSpec.describe LocationSerializer do
  describe 'serialize' do
    let(:geolocation) { build :geolocation }
    let(:location) { create :location, geolocation: geolocation }

    let(:serialized_fields) { LocationSerializer.new(location).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:address_1]).to eq(location.address_1)
      expect(serialized_fields[:address_2]).to eq(location.address_2)
      expect(serialized_fields[:country]).to eq(location.country)
      expect(serialized_fields[:state]).to eq(location.state)
      expect(serialized_fields[:zipcode]).to eq(location.zipcode)
      expect(serialized_fields[:geolocation][:latitude]).to eq(location.geolocation.latitude)
      expect(serialized_fields[:geolocation][:longitude]).to eq(location.geolocation.longitude)
    end
  end
end