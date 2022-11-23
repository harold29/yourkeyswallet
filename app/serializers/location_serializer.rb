class LocationSerializer < ApplicationSerializer
  attributes :address_1,
             :address_2,
             :country,
             :state,
             :zipcode,
             :geolocation

    def geolocation
      GeolocationSerializer.new(object.geolocation).serializable_hash
    end

    class GeolocationSerializer < ApplicationSerializer
      attributes :latitude, :longitude
    end
end