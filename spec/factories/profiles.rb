FactoryBot.define do
  factory :profile do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    phone_number_1 { "MyString" }
    gender { "MyString" }
    birthday { "2022-11-17 23:55:01" }
    user { nil }
  end
end
