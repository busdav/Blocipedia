class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  class << self
    def markdown
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, highlight: true)
    end
  end


  before_save :assign_markdown_content, if: -> { body_changed? }

  private

  def assign_markdown_content
    assign_attributes({
      markdown_content: self.class.markdown.render(body)
      })
  end





  # Instead of setting default value in model, you could do:

  # after_initialize :default_to_public

  # private
  #
  # def default_to_public
  #   self.private = false if self.private.nil?
  # end
end
