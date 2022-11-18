class Profile < ApplicationRecord
  belongs_to :user

  validates_format_of :email,:with => Devise::email_regexp
  validates :email, presence: true, uniqueness: true
  
  validates :phone_number_1, presence: true,
                            numericality: true,
                            uniqueness: true,
                            length: { 
                              minimum: 10,
                              maximum: 15 
                            }
                            
  validates :phone_number_2, numericality: true,
                            allow_nil: true,
                            length: { 
                              minimum: 10,
                              maximum: 15 
                            }

  validates :first_name, presence: true
  validates :last_name, presence: true
end
