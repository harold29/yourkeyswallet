class TransactionPolicy < ApplicationPolicy
  def index?
    user.vip? || user.admin?
  end

  def show?
    return false unless mode.user == user

    user.user? || user.vip? || user.admin?
  end

  def create?
    user.user? || user.vip? || user.admin?
  end

  def update?
    return false unless mode.user == user

    user.user? || user.vip? || user.admin?
  end

  def destroy?
    return false unless mode.user == user

    user.user? || user.vip? || user.admin?
  end
end