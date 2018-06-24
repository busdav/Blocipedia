require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }


  # context "anonymous user" do
  #
  #   before :each do
  #     login_with nil
  #   end
  #
  #   describe "GET #show" do
  #     it "should be redirected to signin" do
  #       get :show
  #       expect( response ).to redirect_to( new_user_session_path )
  #     end
  #   end
  # end



  context "standard user" do

    before :each do
      login_with user
    end

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

    describe "PUT upgrade" do
      it "changes the user role from standard to premium" do
        put :update
        expect 
      end
    end





    describe "PUT #update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }
        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq(my_wiki.id)
        expect(updated_wiki.title).to eq(new_title)
        expect(updated_wiki.body).to eq(new_body)
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to my_wiki
      end
    end



  end
end
