require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }


  context "anonymous user" do

    before :each do
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
  end

end
