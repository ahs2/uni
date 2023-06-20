class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin? || user.student?
  end

  def update?
    user.admin? || user.student?
  end

  def impersonate?
    user.admin?
  end

  def delete?
    true
  end
end
