class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[ show destroy ]

  # GET /profiles
  def index
    @profiles = Profile.all

    render json: @profiles
  end

  # GET /profile/
  def show
    if current_user
      if @profile
        render json: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes]
      else
        render :json, status: :ok
      end
    else
      render :json, status: :unauthorized
    end
  end

  # POST /profiles
  def create
    if current_user
      @profile = ProfileFactory.run(profile_params, current_user)

      if @profile.errors.blank?
        render json: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes], status: :created
      else
        render json: @profile.errors, status: :unprocessable_entity
      end
    else
      render :json, status: :unauthorized
    end
  end

  # PATCH/PUT /profiles/
  def update
    if current_user
      @profile = ProfileFactory.run(profile_params, current_user)

      if @profile && @profile.errors.blank?
        render json: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes]
      else
        render json: @profile&.errors, status: :unprocessable_entity
      end
    else
      render :json, status: :unauthorized
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find_by_user_id(current_user.id)
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number_1, :phone_number_2, :gender, :birthday)
    end

    def with_error_handler(&block)
      begin
        block&.call
      end
    end
end
