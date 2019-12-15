class UserCargo < ApplicationRecord
  belongs_to :user
  belongs_to :cargo
end
