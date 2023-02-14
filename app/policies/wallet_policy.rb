class WalletPolicy < ApplicationPolicy
  def index?
    user.user?
  end

  def show?
    return false if record.user != user
    
    user.user?
  end

  def create?
    user.user? || user.vip? || user.admin?
  end

  def destroy?
    user.user? || user.vip? || user.admin?
  end
end