require 'rails_helper'

RSpec.describe UserCargosController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = create(:employee)
      login(@user) 
    end
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all user_cargos of current user' do
      user = create(:employee)
      cargo1 = create(:cargo, total_quantity: 100, in_stock_quantity: 50)
      cargo2 = create(:cargo, total_quantity: 100, in_stock_quantity: 50)
      cargo3 = create(:cargo, total_quantity: 100, in_stock_quantity: 50)
      uc1 = create(:user_cargo, quantity: 10,cargo: cargo1, user: @user)
      uc2 = create(:user_cargo, quantity: 10,cargo: cargo2, user: @user)
      uc3 = create(:user_cargo, quantity: 10,cargo: cargo3, user: user)
      get :index
      expect(assigns(:user_cargos)).to match_array([uc1, uc2])
    end
  end

  describe "GET #all_users" do
    before(:each) do
      @user = create(:admin)
      @user2 = create(:employee)
      @cargo1 = create(:cargo, total_quantity: 100, in_stock_quantity: 50)
      @cargo2 = create(:cargo, total_quantity: 100, in_stock_quantity: 50)
      @uc1 = create(:user_cargo, quantity: 10,cargo: @cargo1, user: @user)
      @uc2 = create(:user_cargo, quantity: 10,cargo: @cargo1, user: @user2)
      @uc3 = create(:user_cargo, quantity: 10,cargo: @cargo2, user: @user2)
    end
    it "returns http success" do
      login(@user) 
      get :all_users, params: { cargo_id: @cargo1.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns all user_cargos of cargo if is admin' do
      login(@user) 
      get :all_users, params: { cargo_id: @cargo1.id }
      expect(assigns(:user_cargos)).to match_array([@uc1, @uc2])
    end

    it 'redirects to other page' do
      login(@user2)
      get :all_users, params: { cargo_id: @cargo1.id }
      expect(response).to have_http_status(302)
    end
  end

end
