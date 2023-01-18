require 'bitcoin'

class KeyGenerator
  class KeyGeneratorError < StandardError; end
  class CurrencyNotSupportedError < KeyGeneratorError; end

  def self.generate(currency)
    self.new(currency).run
  end

  def initialize(currency)
    @currency = currency
  end

  def run
    case currency.currency_kind.to_sym
    when :bitcoin
      return generate_btc_keys
    else
      raise CurrencyNotSupportedError, "#{currency.name} is not supported"
    end
  end

  private

  attr_reader :currency

  def generate_btc_keys
    key = Bitcoin::Key.generate

    {
      priv_key: key.priv,
      pub_key: key.pub,
      address: key.addr
    }
  end
end