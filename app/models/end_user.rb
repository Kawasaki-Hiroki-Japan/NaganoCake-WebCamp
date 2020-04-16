class EndUser < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_kana, presence: true
  validates :last_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  acts_as_paranoid
  has_many :cart_items, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy
  has_many :orders
end
