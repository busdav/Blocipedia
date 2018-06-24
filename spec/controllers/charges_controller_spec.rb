require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }
  let(:dummy_class) { Class.new { include ChangeUserRole } }



  context "anonymous user" do

    before :each do
      # This simulates an anonymous user
      login_with nil
    end

    describe "GET #index" do
      it "should be redirected to signin" do
        get :new
        expect( response ).to redirect_to( new_user_session_path )
      end
    end
  end



  context "standard user" do

    before :each do
      login_with user
    end


    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end
    end


    describe "POST #create" do
      it "upgrades the current standard user to premium" do
        post :create
        expect(user.role).to eq "premium"
      end
    end
  end
end
