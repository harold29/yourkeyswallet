class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: %i[ show ]


  # GET /location
  def show
    # render json: @location
    if current_user
      if @location
        render json: {
          location: LocationSerializer.new(@location).serializable_hash
        }
      else
        render :json, status: :not_found
      end
    else
      render :json, status: :unauthorized
    end
    
  end

  # POST /locations
  def create
    if current_user
      @location = LocationHandler.run(location_params, current_user)

      if @location.errors.blank?
        render json: {
          location: LocationSerializer.new(@location).serializable_hash
        }, status: :created
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    else
      render :json, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find_by_user_id(current_user.id)
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:address_1, :address_2, :country, :country_code, :state, :state_code, :zipcode, :user_id, geolocation: [:latitude, :longitude])
    end
end
