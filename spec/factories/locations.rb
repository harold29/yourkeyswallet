FactoryBot.define do
  factory :location do
    address_1 { FFaker::Address.street_address }
    address_2 { FFaker::Address.secondary_address }
    country { FFaker::AddressUS.country }
    country_code { FFaker::AddressUS.country_code }
    state { FFaker::AddressUS.state }
    state_code { FFaker::AddressUS.state_abbr }
    zipcode { FFaker::AddressUS.zip_code }
    association :user
  end
end
