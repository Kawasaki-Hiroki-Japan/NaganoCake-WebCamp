class Item < ApplicationRecord
  validates :genre_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: :only_integer
  validates :status, presence: true, inclusion: { in: [true, false] }

  attachment :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items
end
