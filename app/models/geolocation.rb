class Geolocation < ApplicationRecord
    belongs_to :location

    validates :longitude, presence: true
    validates :latitude, presence: true
end
