require 'rails_helper'

RSpec.describe Geolocation, type: :model do

  describe 'Geolocation with all params' do
    let(:location) { build :location, geolocation: geolocation }
    let(:geolocation) { build :geolocation, longitude: '12.34245245234', latitude: '13.3434534534' }

    it 'saves geolocation' do
      expect(location.save).to eq(true)
    end

    it 'geolocation is saved' do
      location.save

      last_geolocation = Geolocation.last

      expect(geolocation.latitude).to eq(last_geolocation.latitude)
      expect(geolocation.longitude).to eq(last_geolocation.longitude)
    end
  end

  describe 'Geolocation with malformed params' do
    context 'with missing params' do
      describe 'with missing latitude' do
        let(:location) { build :location, geolocation: geolocation }
        let(:geolocation) { build :geolocation, longitude: '12.34245245234', latitude: nil }

        it 'It does not save geolocation and return errors' do
          expect(location.save).to eq(false)
          expect(location.errors.full_messages.to_sentence).to eq("Geolocation is invalid")
        end
      end

      describe 'with missing longitude' do
        let(:location) { build :location, geolocation: geolocation }
        let(:geolocation) { build :geolocation, longitude: nil, latitude: '13.3434534534' }

        it 'It does not save geolocation and return errors' do
          expect(location.save).to eq(false)
          expect(location.errors.full_messages.to_sentence).to eq("Geolocation is invalid")
        end
      end
    end
  end
end
