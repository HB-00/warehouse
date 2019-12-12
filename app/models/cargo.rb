class Cargo < ApplicationRecord
  enum category: {
    a: 1,
    b: 2,
    c: 3
  }
  before_create :set_no

  private

  def set_no
    no = ''
    loop do
      no = Time.now.to_i
      break unless Cargo.exists?(no: no)
    end
    self.no = no
  end

end
