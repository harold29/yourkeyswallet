class LocationPolicy < ApplicationPolicy
  def show?
    return false if record.user != user

    user.user? || user.vip?
  end

  def create?
    user.user? || user.vip?
  end
end
