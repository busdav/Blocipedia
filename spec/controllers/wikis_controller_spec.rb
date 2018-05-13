require 'rails_helper'
# include Devise::Test::ControllerHelpers

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki) }


  context "anonymous user" do

    before :each do
      # This simulates an anonymous user
      login_with nil
    end

    describe "GET index" do

      it "should be redirected to signin" do
        get :index
        expect( response ).to redirect_to( new_user_session_path )
      end
    end
  end


  context "logged-in user" do

    before :each do
      # This simulates an anonymous user
      login_with create( :user )
    end

    describe "GET index" do
      it "should let a user see all the wikis" do
        get :index
        expect( response ).to render_template( :index )
      end

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns [my_wiki] to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @post" do
        get :new
        expect(assigns(:post)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Post by 1" do
        expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
      end

      it "assigns the new post to @post" do
        post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(assigns(:post)).to eq Post.last
      end

      it "redirects to the new post" do
        post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to Post.last
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit
        expect(response).to have_http_status(:success)
      end
    end
  end
end
