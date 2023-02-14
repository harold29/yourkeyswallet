require 'rails_helper'

RSpec.describe KeyGenerator do
  context 'generate keys' do
    describe 'with supported currencies' do
      let(:bitcoin) { create :currency, name: "bitcoin", code: 'BTC' }

      subject { described_class.new(bitcoin) }

      describe 'generate keys' do
        it 'returns an object with keys and address' do
          keys = subject.run
          
          expect(keys[:priv_key]).not_to eq(nil)
          expect(keys[:pub_key]).not_to eq(nil)
          expect(keys[:address]).not_to eq(nil)
        end
      end

      describe 'generate bitcoin keys' do
        let(:fake_keys) do
          {
            priv: '71389172347103',
            pub: '132134134134',
            addr: '1341341234134'
          }
        end

        before do
          expect(Bitcoin::Key).
            to receive(:generate).
              and_return(OpenStruct.new(fake_keys))
        end

        it 'returns an object with keys and address' do
          keys = subject.run
          
          expect(keys[:priv_key]).to eq(fake_keys[:priv])
          expect(keys[:pub_key]).to eq(fake_keys[:pub])
          expect(keys[:address]).to eq(fake_keys[:addr])
        end
      end
    end

    describe 'with not supported currencies' do
      let(:us_dollar) { create :currency, name: "US Dollar", code: 'USD' }

      subject { described_class.new(us_dollar) }

      describe 'do not generate keys' do
        it 'raises a CurrencyNotSupportedError' do          
          expect{ subject.run }.to raise_error(KeyGenerator::CurrencyNotSupportedError, "US Dollar is not supported")
        end
      end
    end
  end
end