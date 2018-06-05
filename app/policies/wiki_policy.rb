class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end

# probably add the same for edit, no? or, probably reference in appl policy made to 'update' is enough.



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
