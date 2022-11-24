require 'rails_helper'

RSpec.describe LocationHandler do
  let(:user) { create :user }

  subject { LocationHandler.new(location_payload, user) }

  context 'with all params' do
    let(:location_payload) do
      {
        address_1: 'test1',
        address_2: 'test2',
        country: 'CountryTest1',
        country_code: 'CT',
        state: 'StateTest1',
        state_code: 'ST',
        zipcode: 12345,
        geolocation: {
          latitude: '12.123',
          longitude: '34.567'
        }
      }
    end

    describe 'create location' do
      context '#run' do
        it 'return created location' do
          location = subject.run

          expect(location.address_1).to eq(location_payload[:address_1])
          expect(location.address_2).to eq(location_payload[:address_2])
          expect(location.country).to eq(location_payload[:country])
          expect(location.country_code).to eq(location_payload[:country_code])
          expect(location.state).to eq(location_payload[:state])
          expect(location.state_code).to eq(location_payload[:state_code])
          expect(location.zipcode).to eq(location_payload[:zipcode])
          expect(location.geolocation.latitude).to eq(location_payload[:geolocation][:latitude])
          expect(location.geolocation.longitude).to eq(location_payload[:geolocation][:longitude])
          end
      end
    end
  end

  context 'with malformed params' do
    describe 'with missing params' do
      context 'with missing address_1' do
        let(:location_payload) do
          {
            address_1: '',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: 'CT',
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Address 1 can't be blank")
            end
        end
      end

      context 'with missing address_2' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: nil,
            country: 'CountryTest1',
            country_code: 'CT',
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Address 2 can't be blank")
            end
        end
      end

      context 'with missing country' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: nil,
            country_code: 'CT',
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Country can't be blank")
            end
        end
      end

      context 'with missing country_code' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: nil,
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Country code can't be blank")
            end
        end
      end

      context 'with missing state' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: 'CT',
            state: nil,
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("State can't be blank")
            end
        end
      end

      context 'with missing state_code' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: 'CT',
            state: 'StateTest1',
            state_code: nil,
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("State code can't be blank")
            end
        end
      end

      context 'with missing zipcode' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: 'CT',
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: nil,
            geolocation: {
              latitude: '12.123',
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Zipcode can't be blank")
            end
        end
      end

      context 'with missing latitude' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: 'CT',
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: nil,
              longitude: '34.567'
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Geolocation must exist")
            end
        end
      end

      context 'with missing longitude' do
        let(:location_payload) do
          {
            address_1: 'test1',
            address_2: 'test2',
            country: 'CountryTest1',
            country_code: 'CT',
            state: 'StateTest1',
            state_code: 'ST',
            zipcode: 12345,
            geolocation: {
              latitude: '12.123',
              longitude: nil
            }
          }
        end

        context '#run' do
          it 'return errors' do
            location = subject.run

            expect(location.errors.blank?).not_to eq(nil)
            expect(location.errors.full_messages.to_sentence).to eq("Geolocation must exist")
            end
        end
      end
    end
  end
end