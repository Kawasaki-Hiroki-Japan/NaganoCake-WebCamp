class EndUser < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  acts_as_paranoid
  has_many :cart_items
end
