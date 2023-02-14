class ProfileFactory
  def self.run(profile_params, current_user)
    new(profile_params, current_user).run
  end

  def initialize(profile_params, current_user)
    @first_name = profile_params[:first_name]
    @last_name = profile_params[:last_name]
    @phone_number_1 = profile_params[:phone_number_1]
    @phone_number_2 = profile_params[:phone_number_2]
    @gender = profile_params[:gender]
    @birthday = profile_params[:birthday]
    @current_user = current_user
  end

  def run
    if profile
      return update_profile
    else
      return create_profile
    end
  end

  private

  attr_reader :first_name,
              :last_name,
              :phone_number_1,
              :phone_number_2,
              :gender,
              :birthday,
              :current_user,
              :profile

  def birthday
    @birthday.blank? ? '' : DateTime.parse(@birthday)
  end

  def profile
    @profile = Profile.find_by_user_id(current_user.id) if current_user
  end

  def profile_attributes
    {
      first_name: first_name,
      last_name: last_name,
      email: current_user.email,
      phone_number_1: phone_number_1,
      phone_number_2: phone_number_2,
      gender: gender,
      birthday: birthday,
      user: current_user
    }
  end

  def update_attributes
    update_fields = %i(first_name last_name phone_number_1 phone_number_2 gender birthday)
    update_attributes = {}
    
    update_fields.each do |field|
      update_attributes[field] = send(field) unless send(field).blank?
    end
    
    update_attributes
  end

  def create_profile
    if current_user
      Profile.create(profile_attributes)
    end
  end

  def update_profile
    Pundit.policy(current_user, profile)

    result = profile.update(update_attributes)
    
    if result
      profile
    end
  end
end