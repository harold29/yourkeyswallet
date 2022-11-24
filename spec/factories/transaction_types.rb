FactoryBot.define do
  factory :transaction_type do
    name { 'Payment' }
    description { 'Requester sends money to receiver' }
  end
end
