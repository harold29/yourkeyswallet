require 'rails_helper'

RSpec.describe Wallet, type: :model do
  context 'creation' do
    describe 'Wallet with all params' do
      let(:currency) { create :currency }
      let(:user) { create :user }

      let(:wallet) do
        build :wallet,
          amount: 12.5,
          pubkey: 'testingPubKey',
          pkey: 'testingPrivKey',
          user: user,
          currency: currency
      end

      it 'save wallet' do
        expect(wallet.save).to eq(true)
      end

      it 'wallet is correctly saved' do
        wallet.save

        last_wallet = Wallet.last

        expect(last_wallet.available).to eq(wallet.available)
        expect(last_wallet.deleted).to eq(wallet.deleted)
        expect(last_wallet.amount).to eq(wallet.amount)
        expect(last_wallet.currency_name).to eq(currency.name)
        expect(last_wallet.symbol).to eq(currency.symbol)
        expect(last_wallet.pubkey).to eq(wallet.pubkey)
        expect(last_wallet.pkey).to eq(wallet.pkey)
      end
    end

    describe 'Wallet with malformed params' do
      context 'with missing params' do
        describe 'with missing pubkey' do
          let(:currency) { create :currency }
          let(:user) { create :user }

          let(:wallet) do
            build :wallet,
              pubkey: nil,
              pkey: 'testingPrivKey',
              amount: 12.5,
              user: user,
              currency: currency
          end

          it 'wallet is not saved and return error' do
            expect(wallet.save).to eq(false)
            expect(wallet.errors).to_not eq(nil)
            expect(wallet.errors.full_messages.to_sentence).to eq("Pubkey can't be blank")
          end
        end

        describe 'with missing pkey' do
          let(:currency) { create :currency }
          let(:user) { create :user }

          let(:wallet) do
            build :wallet,
              pubkey: 'testingPubKey',
              pkey: nil,
              amount: 12.5,
              user: user,
              currency: currency
          end

          it 'wallet is not saved and return error' do
            expect(wallet.save).to eq(false)
            expect(wallet.errors).to_not eq(nil)
            expect(wallet.errors.full_messages.to_sentence).to eq("Pkey can't be blank")
          end
        end

        describe 'with missing amount' do
          let(:currency) { create :currency }
          let(:user) { create :user }

          let(:wallet) do
            build :wallet,
              pubkey: 'testingPubKey',
              pkey: 'testingPrivKey',
              amount: nil,
              user: user,
              currency: currency
          end

          it 'wallet is saved and return error' do
            expect(wallet.save).to eq(true)
            expect(wallet.errors).to be_blank
          end
        end
      end
    end
  end

  context 'update' do
    let(:wallet) { create :wallet }

    describe 'with all params' do
      let(:params) do
        {
          amount: 12.5,
          pubkey: 'testingPubKey',
          pkey: 'testingPrivKey',
          available: false,
          deleted: true
        }
      end

      it 'update fields' do
        expect(wallet.update(params)).to eq(true)

        last_wallet = Wallet.last

        expect(last_wallet.amount).to eq(params[:amount])
        expect(last_wallet.pubkey).to eq(params[:pubkey])
        expect(last_wallet.pkey).to eq(params[:pkey])
        expect(last_wallet.available).to eq(params[:available])
        expect(last_wallet.deleted).to eq(params[:deleted])
      end
    end

    describe 'with malformed params' do
      context 'with missing params' do
        describe 'with missing pubkey' do
          it 'does not update walllet' do
            wallet.pubkey = nil
            
            expect(wallet.save).to eq(false)
            expect(wallet.errors).to_not eq(nil)
            expect(wallet.errors.full_messages.to_sentence).to eq("Pubkey can't be blank")
          end
        end

        describe 'with missing pkey' do
          it 'does not update wallet' do
            wallet.pkey = nil
            
            expect(wallet.save).to eq(false)
            expect(wallet.errors).to_not eq(nil)
            expect(wallet.errors.full_messages.to_sentence).to eq("Pkey can't be blank")
          end
        end

        describe 'with missing amount' do
          it 'does not update wallet' do
            wallet.amount = nil
            
            expect(wallet.save).to eq(true)
          end
        end
      end
    end
  end
end
