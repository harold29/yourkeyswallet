require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  context 'creation' do
    describe 'Transaction Type with all params' do
      let(:transaction_type) do
        build :transaction_type,
          name: 'Test',
          description: 'Test description'
      end

      it 'save transaction_type' do
        expect(transaction_type.save).to eq(true)
      end

      it 'transaction_type is correctly saved' do
        transaction_type.save

        last_transaction_type = TransactionType.last

        expect(last_transaction_type.name).to eq(transaction_type.name)
        expect(last_transaction_type.description).to eq(transaction_type.description)
      end
    end

    describe 'Transaction Type with malformed params' do
      context 'with missing params' do
        describe 'with missing transaction type' do
          let(:transaction_type) do
            build :transaction_type,
              name: nil,
              description: 'Test description'
          end

          it 'transaction_type is not saved and return error' do
            expect(transaction_type.save).to eq(false)
            expect(transaction_type.errors).to_not eq(nil)
            expect(transaction_type.errors.full_messages.to_sentence).to eq("Name can't be blank")
          end
        end

        describe 'with missing code' do
          let(:transaction_type) do
            build :transaction_type,
              name: 'Test',
              description: nil
          end

          it 'transaction_type is not saved and return error' do
            expect(transaction_type.save).to eq(true)
            expect(transaction_type.name).to eq('Test')
            expect(transaction_type.description).to eq(nil)
          end
        end
      end

      context 'with mismatched data types' do
        describe 'with name as an integer' do
          let(:transaction_type) { build :transaction_type, name: 7357, description: 'Test description'}

          it 'creates a transaction_type with the integer casted into string' do
            expect(transaction_type.save).to eq(true)

            expect(transaction_type.name).to eq('7357')
            expect(transaction_type.description).to eq('Test description')
          end
        end

        describe 'with description as an integer' do
          let(:transaction_type) { build :transaction_type, name: 'test', description: 1111 }

          it 'creates a transaction_type with the integer casted into string' do
            expect(transaction_type.save).to eq(true)

            expect(transaction_type.name).to eq('test')
            expect(transaction_type.description).to eq('1111')
          end
        end
      end
    end
  end

  context 'update' do
    let(:transaction_type) { create :transaction_type }

    describe 'with all params' do
      let(:params) do
        {
          name: 'Test',
          description: 'Test Description',
        }
      end

      it 'update all fields' do
        expect(transaction_type.update(params)).to eq(true)
        expect(transaction_type.name).to eq(params[:name])
        expect(transaction_type.description).to eq(params[:description])
      end
    end

    describe 'with malformed params' do
      context 'with missing params' do
        describe 'with missing name' do
          it 'does not update transaction_type' do
            transaction_type.name = nil

            expect(transaction_type.save).to eq(false)
            expect(transaction_type.errors).to_not eq(nil)
            expect(transaction_type.errors.full_messages.to_sentence).to eq("Name can't be blank")
          end
        end

        describe 'with missing description' do
          it 'does not update transaction_type' do
            transaction_type.description = nil

            expect(transaction_type.save).to eq(true)
            expect(transaction_type.description).to eq(nil)
          end
        end
      end
    end
  end
end
