class Wiki < ApplicationRecord
  belongs_to :user
  after_initialize :default_to_public


  private

  def default_to_public
    self.private = false if self.private.nil?
  end
end
