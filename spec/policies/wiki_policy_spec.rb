require 'rails_helper'

RSpec.describe WikiPolicy, type: :controller do

  let(:standard_user) { create (:user) }
  let(:premium_user) { create (:premium_user) }
  let(:admin_user) { create (:admin_user) }
  let(:public_wiki) { create (:wiki) }
  let(:private_wiki) { create (:private_wiki) }

  subject { described_class }



  context "standard_user" do

    permissions ".scope" do
      pending "add some examples to (or delete) #{__FILE__}"
    end

    permissions :show? do
      it "grants access to standard user if wiki is public" do
        expect(subject).to permit(standard_user, public_wiki)
      end

      # it "denies access if wiki is private" do
      #
      # end
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




end

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
