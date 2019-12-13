class IoLog < ApplicationRecord
  belongs_to :cargo
  belongs_to :user
  enum kind: [:borrow, :return]
  validate :check_quantity

  private

  def check_quantity
    if borrow?
      total = cargo.in_stock_quantity
      self.errors.add(:quantity, "该货物目前最多可借#{total}件") if quantity > total
    else

    end
  end
end
