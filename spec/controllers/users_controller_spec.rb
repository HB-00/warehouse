require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "redirects" do
      expect {
        post :create, params: { user: { email: 'abc@qq.com', password: '111111', password_confirmation: '111111'}}, xhr: true
    }.to change { User.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

end
