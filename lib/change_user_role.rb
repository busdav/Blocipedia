module ChangeUserRole

  def upgrade_user
    if current_user.role == "standard"
      current_user.premium!
    end
  end

  def downgrade_user
    if current_user.role == "premium"
      current_user.standard!
    end
    @wikis = Wiki.where(:user_id => current_user.id)
    @wikis.each do |wiki|
      wiki.private = false
    end
  end
end
