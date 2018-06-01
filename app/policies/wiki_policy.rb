class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end

# probably add the same for edit, no? or, probably reference in appl policy made to 'update' is enough.



  class Scope < Scope
    def resolve
      scope
      # replace with appropriate scope, eg below. Goal is that standard and premium users only sees public wikis. admin users see all wikis.
      # probably have to put 'update' etc. under the scope??
      # although no, I believe that scope and actions are TESTED individually. I then simply need to make sure I use "policy_scope" in the controller.
      # That will make the respective action ONLY accessible to the appropriate scope. check.
      # if user.admin?
      #   scope.all
      # else
      #   scope.where(:published => true)
      # end
    end
  end
end
