class NilClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotDefinedError, "Cannot scope NilClass"
    end
  end

  def show?
    false # Nobody can see nothing
  end

  def index?
    false # Nobody can see nothing
  end

  def create?
    false # Nobody can see nothing
  end

  def update?
    false # Nobody can see nothing
  end

  def destroy?
    false # Nobody can see nothing
  end
end