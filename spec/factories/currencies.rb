FactoryBot.define do
  factory :currency do
    name { FFaker::Geolocation.lat }
    symbol { FFaker::Geolocation.lng }
  end
end
