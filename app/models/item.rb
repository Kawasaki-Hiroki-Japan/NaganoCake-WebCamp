class Item < ApplicationRecord
  validates :genre_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  attachment :image
  belongs_to :genre
  has_many :cart_items
end
