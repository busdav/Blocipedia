# require 'rails_helper'
#
# RSpec.describe Users::RegistrationsController, type: :controller do
#
#   let(:private_wiki) { create (:private_wiki) }
#   let(:user) { create(:user) }
#   let(:admin_user) { create(:admin_user) }
#   let(:premium_user) { create(:premium_user) }
#   let(:dummy_class) { Class.new { include ChangeUserRole } }
#
#
#
#
#   context "premium user" do
#
#     # before :each do
#     #   login_as premium_user
#     # end
#
#
#     describe "#downgrade_user" do
#       it "downgrades the user" do
#         premium_user
#         dummy_class.downgrade_user(premium_user)
#         expect(premium_user.role).to eq "standard"
#       end
#
#       it "sets the user's private wikis to public" do
#         premium_user.update(role: "premium")
#         private_wiki.update(user_id: premium_user.id)
#         dummy_class.downgrade_user(premium_user)
#         expect(private_wiki.private).to eq false
#       end
#     end
#   end
# end
