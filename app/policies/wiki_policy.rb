class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end

# probably add the same for edit, no? or, probably reference in appl policy made to 'update' is enough.



  class Scope < Scope
    # wiki = Wiki.find(params[:id])
    def resolve
      if user.admin?
        scope.all
      # elsif wiki.user == user
      #   scope.where(:private => false) && scope.where(:id => wiki.id) ---OR is it more:
      elsif user == @current_user
        # not working: correct:
        scope.where(:private => false) && scope.where(:user => user)
      else
        scope.where(:private => false)
      end
    end
  end
end
