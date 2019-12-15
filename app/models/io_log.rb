class IoLog < ApplicationRecord
  belongs_to :cargo
  belongs_to :user
  enum kind: [:borrow, :return]
  validate :check_quantity
  validate :check_code
  after_create :update_cargo_info
  after_create :refresh_cargo_code, if: -> { borrow? }

  private

  def check_code
    if borrow?
      cargo = Cargo.find_by(code: code.strip.upcase)
      if cargo&.id != cargo_id
        self.errors.add(:code, '无效的提取码!')
      end
    end
  end

  def refresh_cargo_code
    cargo.update code: cargo.new_code
  end

  def update_cargo_info
    user_cargo = UserCargo.find_or_initialize_by(user_id: user_id, cargo_id: cargo_id)
    if borrow?
      user_cargo.quantity += quantity
      cargo.in_stock_quantity -= quantity
      user_cargo.save
    elsif return?
      user_cargo.quantity -= quantity
      cargo.in_stock_quantity += quantity
      if user_cargo.quantity <= 0
        user_cargo.destroy
      else
        user_cargo.save
      end
    end
    cargo.save
  end

  def check_quantity
    if borrow?
      total = cargo.in_stock_quantity
      self.errors.add(:quantity, "该货物目前最多可借#{total}件") if quantity > total
    elsif return?
      total = user.user_cargos.find_by(cargo_id: cargo_id)&.quantity
      return self.errors.add(:quantity, "您没有借过改货物，无需归还") if total.nil?
      self.errors.add(:quantity, "该货物目前最多归还#{total}件") if quantity > total
    end
  end
end
