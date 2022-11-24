class Location < ApplicationRecord
  belongs_to :user
  has_one :geolocation, validate: true, required: true

  validates :address_1, presence: true
  validates :address_2, presence: true
  validates :country, presence: true
  validates :country_code, presence: true
  validates :state, presence: true
  validates :state_code, presence: true
  validates :zipcode, presence: true
end
