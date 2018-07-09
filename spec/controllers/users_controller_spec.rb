require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }
  let(:dummy_class) { Class.new { include ChangeUserRole } }


  context "anonymous user" do

    before :each do
      login_with nil
    end

    # describe "GET #show" do
    #   it "should be redirected to signin" do
    #     get :show
    #     expect( response ).to redirect_to( new_user_session_path )
    #   end
    # end
  end



  context "standard user" do

    before :each do
      login_with user
    end

    # describe "#upgrade_user" do
    #   it "upgrades the current user" do
    #     dummy_class.upgrade_user
    #     expect(user.role).to eq "premium"
    #   end
    # end
    #
    # describe "#downgrade_user" do
    #   it "downgrades the current user" do
    #     dummy_class.upgrade_user
    #     dummy_class.downgrade_user
    #     expect(user.role).to eq "standard"
    #   end
    # end

    # describe "GET #show" do
    #   it "returns http success" do
    #     get :show
    #     expect(response).to have_http_status(:success)
    #   end
    #
    #   it "renders the #show view" do
    #     get :show
    #     expect(response).to render_template :show
    #   end
    # end
  end
end
