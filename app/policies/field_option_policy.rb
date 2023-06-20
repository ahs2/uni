class FieldOptionPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin?
  end

  def switch_tenant?
    user.admin?
  end

  def delete?
    false
  end
end
