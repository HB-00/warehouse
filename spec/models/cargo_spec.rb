require 'rails_helper'

RSpec.describe Cargo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:total_quantity) }
    it { should validate_presence_of(:in_stock_quantity) }
    it { should have_many(:io_logs) }
    it { should have_many(:user_cargos) }
  end

  describe 'create cargo' do
    it 'has default code' do
      cargo = create(:cargo, code: nil)
      expect(cargo.code).not_to be_nil
    end

    it 'has default no' do
      cargo = create(:cargo, no: nil)
      expect(cargo.no).not_to be_nil
    end

    it 'removes blank space of category and name' do
      cargo = create(:cargo, name: ' abc ', category: ' def ')
      expect(cargo.name).to eq('abc')
      expect(cargo.category).to eq('def')
    end

  end
end
