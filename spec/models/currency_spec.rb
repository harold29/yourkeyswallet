require 'rails_helper'

RSpec.describe Currency, type: :model do
  context 'creation' do
    describe 'Currency with all params' do
      let(:currency) do
        build :currency,
          name: 'US Dolar',
          code: 'USD',
          symbol: '$'
      end

      it 'save currency' do
        expect(currency.save).to eq(true)
      end

      it 'currency is correctly saved' do
        currency.save

        last_currency = Currency.last

        expect(last_currency.name).to eq(currency.name)
        expect(last_currency.code).to eq(currency.code)
        expect(last_currency.symbol).to eq(currency.symbol)
      end
    end

    describe 'Currency with malformed params' do
      context 'with missing params' do
        describe 'with missing name' do
          let(:currency) do
            build :currency,
              name: nil,
              code: 'USD',
              symbol: '$'
          end

          it 'currency is not saved and return error' do
            expect(currency.save).to eq(false)
            expect(currency.errors).to_not eq(nil)
            expect(currency.errors.full_messages.to_sentence).to eq("Name can't be blank")
          end
        end

        describe 'with missing code' do
          let(:currency) do
            build :currency,
              name: 'US Dolar',
              code: nil,
              symbol: '$'
          end

          it 'currency is not saved and return error' do
            expect(currency.save).to eq(false)
            expect(currency.errors).to_not eq(nil)
            expect(currency.errors.full_messages.to_sentence).to eq("Code can't be blank")
          end
        end

        describe 'with missing symbol' do
          let(:currency) do
            build :currency,
              name: 'US Dolar',
              code: 'USD',
              symbol: nil
          end

          it 'save currency' do
            expect(currency.save).to eq(true)
          end
    
          it 'currency is correctly saved' do
            currency.save
    
            last_currency = Currency.last
    
            expect(last_currency.name).to eq(currency.name)
            expect(last_currency.code).to eq(currency.code)
            expect(last_currency.symbol).to eq(nil)
          end
        end
      end
    end
  end

  context 'update' do
    let(:currency) { create :currency }

    describe 'with all params' do
      let(:params) do
        {
          name: 'US Dollar',
          code: 'USD',
          symbol: '$'
        }
      end

      it 'update all fields' do
        expect(currency.update(params)).to eq(true)
        expect(currency.name).to eq(params[:name])
        expect(currency.code).to eq(params[:code])
        expect(currency.symbol).to eq(params[:symbol])
      end
    end

    describe 'with malformed params' do
      context 'with missing params' do
        describe 'with missing name' do
          it 'does not update currency' do
            currency.name = nil

            expect(currency.save).to eq(false)
            expect(currency.errors).to_not eq(nil)
            expect(currency.errors.full_messages.to_sentence).to eq("Name can't be blank")
          end
        end

        describe 'with missing code' do
          it 'does not update currency' do
            currency.code = nil

            expect(currency.save).to eq(false)
            expect(currency.errors).to_not eq(nil)
            expect(currency.errors.full_messages.to_sentence).to eq("Code can't be blank")
          end
        end

        describe 'with missing code' do
          it 'update currency' do
            currency.symbol = nil

            expect(currency.save).to eq(true)
          end
        end
      end

      context 'with mismatched data types' do
        describe 'with name as an integer' do
          let(:currency) { build :currency, name: 7357, code: 'TST', symbol: '$'}

          it 'creates a currency with the integer casted into string' do
            expect(currency.save).to eq(true)

            expect(currency.name).to eq('7357')
            expect(currency.code).to eq('TST')
            expect(currency.symbol).to eq('$')
          end
        end

        describe 'with code as an integer' do
          let(:currency) { create :currency, name: 'test', code: 757, symbol: '$'}

          it 'creates a currency with the integer casted into string' do
            expect(currency.save).to eq(true)

            expect(currency.name).to eq('test')
            expect(currency.code).to eq('757')
            expect(currency.symbol).to eq('$')
          end
        end

        describe 'with symbol as an integer' do
          let(:currency) { create :currency, name: 'test', code: 'TST', symbol: 7}

          it 'creates a currency with the integer casted into string' do
            expect(currency.save).to eq(true)

            expect(currency.name).to eq('test')
            expect(currency.code).to eq('TST')
            expect(currency.symbol).to eq('7')
          end
        end
      end
    end
  end
end
