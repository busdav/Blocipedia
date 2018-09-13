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
      if user.role == "admin"
        scope.all
      elsif user.role == "premium"
        scope.all
      elsif user.role == "standard"
        # all_wikis = scope.all
        # wikis = []
        # all_wikis.each do |wiki|
        #   if wiki.private == false || wiki.user = user || wiki.collaborators.include?(user)
        #     wikis << wiki
        #   end
        # end
        # wikis
        wikis = scope.where(:private => false).or(scope.where(:user => user))
      end
    end
  end

  # class Scope
  #   attr_reader :user, :scope
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end
  #   def resolve
  #     wikis = []
  #     if user.role == 'admin'
  #       wikis = scope.all # if the user is an admin, show them all the wikis
  #     elsif user.role == 'premium'
  #       all_wikis = scope.all
  #       all_wikis.each do |wiki|
  #         if wiki.private == false || wiki.user == user || wiki.collaborators.include?(user)
  #           wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
  #         end
  #       end
  #     else # this is the lowly standard user
  #       all_wikis = scope.all
  #       wikis = []
  #       all_wikis.each do |wiki|
  #         if wiki.private == false || wiki.collaborators.include?(user)
  #           wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
  #         end
  #       end
  #     end
  #     wikis # return the wikis array we've built up
  #   end
  # end
end
