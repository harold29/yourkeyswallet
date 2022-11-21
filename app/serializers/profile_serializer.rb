class ProfileSerializer < ApplicationSerializer
  attributes :first_name,
             :last_name,
             :email,
             :phone_number_1,
             :phone_number_2,
             :gender

  attribute :birthday do |object|
    object.birthday.blank? ? '' : object.birthday.strftime("%Y-%m-%d")
  end
end