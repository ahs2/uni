class MenuPolicy < ApplicationPolicy
  def users?
    user.admin?
  end

  def universities?
    user.admin?
  end

  def students?
    user.admin?
  end

  def transactions?
    user.admin?
  end

  def settings?
    user.admin?
  end

  def school_years?
    user.admin?
  end

  def pre_registration?
    user.student?
  end

  def field?
    user.admin?
  end

  def field_option?
    user.admin?
  end
end
