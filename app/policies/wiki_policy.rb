class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end

# probably add the same for edit, no? or, probably reference in appl policy made to 'update' is enough.



  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:private => false)
      end
    end
  end
end
