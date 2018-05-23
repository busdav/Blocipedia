require 'rails_helper'

RSpec.describe WikiPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end


# Example:

# describe PostPolicy do
#   subject { described_class }
#
#   permissions :update?, :edit? do
#     it "denies access if post is published" do
#       expect(subject).not_to permit(User.new(admin: false), Post.new(published: true))
#     end
#
#     it "grants access if post is published and user is an admin" do
#       expect(subject).to permit(User.new(admin: true), Post.new(published: true))
#     end
#
#     it "grants access if post is unpublished" do
#       expect(subject).to permit(User.new(admin: false), Post.new(published: false))
#     end
#   end
# end
