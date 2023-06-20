class StudentPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin? || user.student?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin? || user.student?
  end

  def delete?
    false
  end
end
