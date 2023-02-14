FactoryBot.define do
  factory :wallet do
    pubkey { '0123456789' }
    pkey { '0987654321' }
    address { '2492984975SKDJFGSDKFJ4395802450274028743JFGJSDFLG'}
    available { true }
    deleted { false }
    amount { 14.5 }
    association :user
    association :currency
  end
end
