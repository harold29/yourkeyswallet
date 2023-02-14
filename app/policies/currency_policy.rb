class CurrencyPolicy < ApplicationPolicy
  def index?
    user.user? || user.vip? || user.admin?
  end

  def show?
    user.user? || user.vip? || user.admin?
  end

  def create?
    user.vip? || user.admin?
  end

  def update?
    user.vip? || user.admin?
  end

  def destroy?
    user.vip? || user.admin?
  end
end
