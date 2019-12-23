require 'rails_helper'

RSpec.describe IoLogsController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = create(:user)
      login(@user)
    end
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    before(:each) do
      @user = create(:user)
      login(@user)
    end
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before(:each) do
      @user = create(:user)
      login(@user)
      @cargo = create(:cargo, code: '12345', total_quantity: 100, in_stock_quantity: 50)
    end
    it "returns http success" do
      expect {
        post :create, params: { io_log: { kind: :borrow, quantity: 10, cargo_id: @cargo.id, code: @cargo.code}}
    }.to change { IoLog.count }.by(1)
      expect(response).to have_http_status(302)
    end
  end

end
