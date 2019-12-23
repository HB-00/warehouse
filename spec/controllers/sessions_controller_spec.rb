require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    context 'without login' do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
        expect(response).to render_template('new')
      end
    end

    context 'logged in' do
      it 'redirect to root path' do
        user = create(:user)
        login(user)
        get :new
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    let (:user1) { create(:admin, email: 'jessy@gmail.com', password: '1111111111')}
    context 'with valid user' do
      it "returns http success" do
        user1
        post :create, params: { session: { email: 'jessy@gmail.com', password: '1111111111' } }, xhr: true
        expect(response).to have_http_status(:success)
        expect(response).to render_template('create_succeeded')
      end
    end
    
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      user = create(:user)
      login(user)
      delete :destroy
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)

    end
  end

end
