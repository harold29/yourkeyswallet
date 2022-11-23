require 'rails_helper'

RSpec.describe Location, type: :model do
  context 'creation' do
    let(:user) { create :user }
    let(:geolocation) { build :geolocation }

    describe 'Location with all params' do
      let(:location) do 
        build :location,
          address_1: 'test address 1',
          address_2: 'test address 2',
          country: 'Venezuela',
          country_code: 'VE',
          state: 'Aragua',
          state_code: 'AR',
          zipcode: 12345,
          user: user,
          geolocation: geolocation
      end

      it 'save location' do
        expect(location.save).to eq(true)
      end

      it 'location is correctly saved' do
        location.save

        last_location = Location.last

        expect(last_location.address_1).to eq(location.address_1)
        expect(last_location.address_2).to eq(location.address_2)
        expect(last_location.country).to eq(location.country)
        expect(last_location.country_code).to eq(location.country_code)
        expect(last_location.state).to eq(location.state)
        expect(last_location.state_code).to eq(location.state_code)
        expect(last_location.zipcode).to eq(location.zipcode)
      end
    end

    describe 'Location with malformed params' do
      context 'with missing params' do
        describe 'with missing address_1' do
          let(:location) do 
            build :location,
              address_1: nil,
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 12345,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Address 1 can't be blank")
          end
        end

        describe 'with missing address_2' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: nil,
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 12345,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Address 2 can't be blank")
          end
        end

        describe 'with missing country' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: nil,
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 12345,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Country can't be blank")
          end
        end

        describe 'with missing country_code' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: nil,
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 12345,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Country code can't be blank")
          end
        end

        describe 'with missing State' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: 'VE',
              state: nil,
              state_code: 'AR',
              zipcode: 12345,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("State can't be blank")
          end
        end

        describe 'with missing State Code' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: nil,
              zipcode: 12345,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("State code can't be blank")
          end
        end

        describe 'with missing Zipcode' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: nil,
              user: user,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Zipcode can't be blank")
          end
        end

        describe 'with missing User' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 12345,
              user: nil,
              geolocation: geolocation
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("User must exist")
          end
        end

        describe 'with missing User' do
          let(:location) do 
            build :location,
              address_1: 'test address 1',
              address_2: 'test address 2',
              country: 'Venezuela',
              country_code: 'VE',
              state: 'Aragua',
              state_code: 'AR',
              zipcode: 12345,
              user: user,
              geolocation: nil
          end

          it 'location is not saved and return error' do
            expect(location.save).to eq(false)
            expect(location.errors).to_not eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Geolocation must exist")
          end
        end
      end
    end
  end

  context 'update' do
    let(:user) { create :user }
    let(:geolocation) { build :geolocation }
    let(:location) do
      create :location,
        address_1: 'test address 1',
        address_2: 'test address 2',
        country: 'Venezuela',
        country_code: 'VE',
        state: 'Aragua',
        state_code: 'AR',
        zipcode: 12345,
        user: user,
        geolocation: geolocation
    end

    describe 'with all params' do
      let(:params) do
        {
          address_1: 'update test address 1',
          address_2: 'update test address 2',
          country: 'United States',
          country_code: 'US',
          state: 'California',
          state_code: 'CA',
          zipcode: 67890,
        }
      end

      it 'update all fields' do
        expect(location.update(params)).to eq(true)
        expect(location.address_1).to eq(params[:address_1])
        expect(location.address_2).to eq(params[:address_2])
        expect(location.country).to eq(params[:country])
        expect(location.country_code).to eq(params[:country_code])
        expect(location.state).to eq(params[:state])
        expect(location.state_code).to eq(params[:state_code])
        expect(location.zipcode).to eq(params[:zipcode])
      end
    end

    describe 'with malformed params' do
      context 'with missing address_1' do
        it 'does not update location' do
          location.address_1 = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("Address 1 can't be blank")
        end
      end

      context 'with missing address_2' do
        it 'does not update location' do
          location.address_2 = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("Address 2 can't be blank")
        end
      end

      context 'with missing country' do
        it 'does not update location' do
          location.country = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("Country can't be blank")
        end
      end

      context 'with missing country_code' do
        it 'does not update location' do
          location.country_code = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("Country code can't be blank")
        end
      end

      context 'with missing state' do
        it 'does not update location' do
          location.state = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("State can't be blank")
        end
      end

      context 'with missing state_code' do
        it 'does not update location' do
          location.state_code = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("State code can't be blank")
        end
      end

      context 'with missing zipcode' do
        it 'does not update location' do
          location.zipcode = nil

          expect(location.save).to eq(false)
          expect(location.errors).to_not eq(nil)
          expect(location.errors.full_messages.to_sentence).to eq("Zipcode can't be blank")
        end
      end
    end
  end
end
