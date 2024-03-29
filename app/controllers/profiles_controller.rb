class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[ show ]

  # GET /profile/
  def show
    if current_user

      if @profile
        authorize @profile

        render json: {
          profile: ProfileSerializer.new(@profile).serializable_hash
        }
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

      authorize @profile

      if @profile.errors.blank?
        render json: {
          profile: ProfileSerializer.new(@profile).serializable_hash
        }, status: :created
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
        render json: {
          profile: ProfileSerializer.new(@profile).serializable_hash
        }
      else
        render json: @profile&.errors, status: :unprocessable_entity
      end
    else
      render :json, status: :unauthorized
    end
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
