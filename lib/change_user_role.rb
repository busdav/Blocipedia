module ChangeUserRole

  def upgrade
    if current_user.role == "standard"
      current_user.premium!
    end
  end

  def downgrade
    if current_user.role == "premium"
      current_user.standard!
    end
  end
end
