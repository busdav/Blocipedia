class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end


  class Scope < Scope
    def resolve
      scope
      # replace with appropriate scope, eg: 
      # if user.admin?
      #   scope.all
      # else
      #   scope.where(:published => true)
      # end
    end
  end
end
