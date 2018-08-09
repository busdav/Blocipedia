require 'rails_helper'

RSpec.describe ChangeUserRole, type: :helper do

  let(:private_wiki) { create (:private_wiki) }
  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }
  let(:premium_user) { create(:premium_user) }



  context "standard user" do

    describe "#upgrade_user" do
      it "upgrades the user" do
        user
        upgrade_user(user)
        expect(user.role).to eq "premium"
      end
    end
  end



  context "premium user" do

    describe "#downgrade_user" do
      it "downgrades the user" do
        premium_user
        downgrade_user(premium_user)
        expect(premium_user.role).to eq "standard"
      end

      before { private_wiki.update(user_id: premium_user.id) }

      it "sets the user's private wikis to public" do
        # pp premium_user
        # pp private_wiki
        downgrade_user(premium_user)
        # pp premium_user
        # pp private_wiki
        expect(premium_user.wikis[0].private).to eq false
        # expect(private_wiki.private).to eq false
      end
    end
  end
end
