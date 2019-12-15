class Cargo < ApplicationRecord
  before_save :set_attributes
  before_create :set_no
  before_create :set_code
  has_many :io_logs
  has_many :user_cargos
  validates :name, :category, :total_quantity, :in_stock_quantity, presence: true
  validates :code, presence: true, uniqueness: true

  def new_code
    strs = ('a'..'z').to_a + (0..9).to_a
    code = ''
    loop do
      code = strs.sample(8)
      code = code.join.upcase
      break unless Cargo.exists?(code: code)
    end
    code
  end

  private

  def set_no
    no = ''
    loop do
      no = Time.now.to_i
      break unless Cargo.exists?(no: no)
    end
    self.no = no
  end

  def set_code
    self.code = new_code
  end

  def set_attributes
    self.category = category.strip
    self.name = name.strip
  end

end
