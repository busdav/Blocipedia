class Wiki < ApplicationRecord
  belongs_to :user




  # Instead of setting default value in model, you could do:

  # after_initialize :default_to_public

  # private
  #
  # def default_to_public
  #   self.private = false if self.private.nil?
  # end
end
