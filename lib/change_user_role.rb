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
  end
end
