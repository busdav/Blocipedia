module ChangeUserRole

  def upgrade_user(user)
    if user.role == "standard"
      user.premium!
    end
  end

  def downgrade_user(user)
    if user.role == "premium"
      user.standard!
      @wikis = Wiki.where(:user_id => user.id)
      @wikis.update_all(private: false)
    end
  end
end
