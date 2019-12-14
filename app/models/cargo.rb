class Cargo < ApplicationRecord
  before_save :set_attributes
  before_create :set_no
  has_many :io_logs
  has_many :user_cargos
  validates :name, :category, :total_quantity, :in_stock_quantity, presence: true

  private

  def set_no
    no = ''
    loop do
      no = Time.now.to_i
      break unless Cargo.exists?(no: no)
    end
    self.no = no
  end

  def set_attributes
    self.category = category.strip
    self.name = name.strip
  end

end
