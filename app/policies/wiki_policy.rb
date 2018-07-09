class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    if record.private?
      user.admin? || user.premium? || record.try(:user) == user
    else
      user.present?
    end
  end

  def create?
    if record.private?
      user.admin? || user.premium?
    else
      user.present?
    end
    # user.present?
  end

  def new?
    create?
  end

  def update?
    if record.private?
      user.admin? || user.premium? || record.try(:user) == user
    else
      user.present?
    end
  end

  def edit?
    update?
  end

  def destroy?
      user.admin? || record.try(:user) == user
  end


  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        scope.all
      elsif user.standard?
        scope.where(:private => false).or(scope.where(:user => user))
      end
    end
  end
end
