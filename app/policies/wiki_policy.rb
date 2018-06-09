class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    if record.private?
      user.admin? || record.try(:user) == user
    else
      user.present?
    end
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    if record.private?
      user.admin? || record.try(:user) == user
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
        scope.where(:private => false).or(scope.where(:user => user))
      elsif user.standard?
        scope.where(:private => false).or(scope.where(:user => user))
      end
    end
  end
end
