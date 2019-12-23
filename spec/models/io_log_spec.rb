require 'rails_helper'

RSpec.describe IoLog, type: :model do
  describe 'validations' do
    it { should belong_to(:user) }
    it { should belong_to(:cargo) }

    it 'raise error with too much quantity' do
      user = create(:user)
      cargo = create(:cargo, total_quantity: 100, in_stock_quantity: 20)
      user_cargo = create(:user_cargo, user: user, cargo: cargo, quantity: 5)
      expect {create(:borrow_io_log, quantity: 30, cargo: cargo, user: user, code: cargo.code)}.to raise_error(ActiveRecord::RecordInvalid)
      expect {create(:return_io_log, quantity: 10, cargo: cargo, user: user, code: cargo.code)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'create io_log' do
    before(:each) do
      @user = create(:user)
      @cargo = create(:cargo, total_quantity: 100, in_stock_quantity: 20)
      @user_cargo = create(:user_cargo, user: @user, cargo: @cargo, quantity: 5)
    end
    it 'updates cargo_info' do
      create(:borrow_io_log, quantity: 10, cargo: @cargo, user: @user, code: @cargo.code)
      expect(@cargo.reload.in_stock_quantity).to eq(10)
      expect(@user_cargo.reload.quantity).to eq(15)
      create(:return_io_log, quantity: 2, cargo: @cargo, user: @user, code: @cargo.reload.code)
      expect(@cargo.reload.in_stock_quantity).to eq(12)
      expect(@user_cargo.reload.quantity).to eq(13)
    end

    it 'refreshs cargo code' do
      code = @cargo.code
      create(:borrow_io_log, quantity: 10, cargo: @cargo, user: @user, code: @cargo.code)
      expect(@cargo.reload.code).not_to eq(code)
    end
  end
end
