class LocationHandler
  def self.run(location_params, current_user)
    new(location_params, current_user).run
  end

  def initialize(location_params, current_user)
    @address_1 = location_params[:address_1]
    @address_2 = location_params[:address_2]
    @country = location_params[:country]
    @country_code = location_params[:country_code]
    @state = location_params[:state]
    @state_code = location_params[:state_code]
    @zipcode = location_params[:zipcode]
    @latitude = location_params[:geolocation][:latitude]
    @longitude = location_params[:geolocation][:longitude]
    @current_user = current_user
  end

  def run
    create_location

    return location
  end

  private

  attr_accessor :address_1,
                :address_2,
                :country,
                :country_code,
                :state,
                :state_code,
                :zipcode,
                :latitude,
                :longitude,
                :current_user,
                :location,
                :geolocation

  def location_payload
    {
      address_1: address_1,
      address_2: address_2,
      country: country,
      country_code: country_code,
      state: state,
      state_code: state_code,
      zipcode: zipcode,
      user: current_user
    }
  end

  def geolocation_payload
    {
      latitude: latitude,
      longitude: longitude
    }
  end
  
  def get_location
    @location = Location.find_by_user_id(current_user.id)
  end

  def create_location
    create_geolocation

    @location = Location.new(location_payload)
    @location.geolocation = geolocation

    @location.save
  end

  def create_geolocation
    if latitude && longitude 
      @geolocation = Geolocation.create(geolocation_payload)
    end
  end

end