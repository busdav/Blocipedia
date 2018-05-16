require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki) }
  let(:user) { create(:user) }



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
      login_with create( :user )
    end


    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect( response ).to render_template( :index )
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

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end


    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user } }
        expect(response).to redirect_to Wiki.last
      end
    end



    describe "GET #show" do
      it "returns http success" do
        get :show, params: {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
