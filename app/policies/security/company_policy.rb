class Security::CompanyPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def show?
    user.admin?
  end

  def index?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
