FactoryBot.define do
  factory :currency do
    currency_name = FFaker::Currency.name
    name { currency_name }
    code { FFaker::Currency.code }
    symbol { FFaker::Currency.symbol }
    currency_kind { currency_name.parameterize.underscore }
  end
end
