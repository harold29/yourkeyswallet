class WalletBuilder
  class WalletBuilderError < StandardError; end
  class CurrencyNotSupportedError < WalletBuilderError; end
  class EmptyCurrencyKindError < WalletBuilderError; end

  def self.run(user, currency_kind)
    new(user, currency_kind).run
  end

  def initialize(user, currency_kind)
    @user = user
    @currency_kind = currency_kind
  end

  def run
    validate_attributes

    initialize_wallet

    get_currency
    generate_keys if currency_kind && wallet.currency

    wallet
  rescue KeyGenerator::CurrencyNotSupportedError => e
    # TODO: define log, metric and how to handle it
    raise CurrencyNotSupportedError, "#{currency_kind} is not a supported currency for wallets"
  end

  private

  attr_reader :wallet,
              :user,
              :currency_kind

  def validate_attributes
    raise EmptyCurrencyKindError, "The currency_kind field is empty" unless currency_kind
  end

  def initialize_wallet
    @wallet = Wallet.new(user: user)
  end

  def get_currency
    currency = Currency.find_by(currency_kind: currency_kind)

    raise CurrencyNotSupportedError, "#{currency_kind} is not a supported currency for wallets" unless currency

    wallet.currency = currency
  end
  
  def generate_keys
    keys = KeyGenerator.generate(wallet.currency)

    wallet.address = keys[:addr]
    wallet.pubkey = keys[:pub_key]
    wallet.pkey = keys[:priv_key]
  end

end