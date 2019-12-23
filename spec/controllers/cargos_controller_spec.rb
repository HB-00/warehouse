require 'rails_helper'

RSpec.describe CargosController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = create(:admin)
      login(@user) 
    end
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #new" do
    before(:each) do
      @user = create(:admin)
      login(@user) 
    end
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before(:each) do
      @user = create(:admin)
      login(@user) 
    end
    it "returns http success" do
      expect { post :create, params: { cargo: { name: 'abc', category: 'aaa', total_quantity: 100,
       in_stock_quantity: 100, description: 'good to know' } } }.to change { Cargo.count }.by(1)
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @user = create(:admin)
      login(@user) 
      @cargo = create(:cargo)
    end
    it "returns http success" do
      get :edit, params: { id: @cargo.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    before(:each) do
      @user = create(:admin)
      @cargo = create(:cargo, name: 'abc')
      login(@user) 
    end
    it "redirects to other page" do
      patch :update, params: { id: @cargo.id, cargo: { name: 'def' } }
      expect(@cargo.reload.name).to eq('def')
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:admin)
      @cargo = create(:cargo, name: 'abc')
      login(@user) 
    end
    it "redirects to other page" do
      delete :destroy, params: { id: @cargo.id }

      expect(response).to have_http_status(302)
    end
  end

end
