class Item < ApplicationRecord
  validates :genre_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  attachment :image
  belongs_to :genre
end
