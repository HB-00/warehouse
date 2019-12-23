require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_many(:io_logs) }
    it { should have_many(:user_cargos) }

    it 'raise error with invalid email' do
      expect {create(:admin, email: 'df#CC@qq.33')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'create user' do
    it 'has default role' do
      user = create(:user, role: nil)
      expect(user.role).to eq('employee')
    end

    it 'save the eamil with downcase' do
      user = create(:user, email: 'AbCd@gmail.com')
      expect(user.email).to eq('abcd@gmail.com')
    end
  end
end
