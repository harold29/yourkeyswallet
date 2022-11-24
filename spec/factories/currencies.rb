FactoryBot.define do
  factory :currency do
    name { FFaker::Currency.name }
    code { FFaker::Currency.code }
    symbol { FFaker::Currency.symbol }
  end
end
