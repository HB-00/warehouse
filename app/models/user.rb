class User < ApplicationRecord
  has_secure_password
  enum role: [:employee, :admin]
  validates :password, length: { in: (6..20) }, on: :create
  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  before_save :set_role, if: -> { role.nil? }
  before_save :config_email

  def self.digest(string)
    cost = BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def wrong_password_cache_key
    "wrong-password-#{id}"
  end

  def rest_wrong_password_count
    Rails.cache.delete(wrong_password_cache_key)
  end

  private

  def set_role
    self.role = :employee
  end

  def config_email
    self.email = email.to_s.downcase
  end
  
end
