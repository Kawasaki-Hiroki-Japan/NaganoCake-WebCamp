class Item < ApplicationRecord
  validates :genre_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: :only_integer
  validates :status, presence: true, inclusion: { in: [true, false] }

  include SearchCop
  attachment :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items

  search_scope :keyword do
    attributes :name
  end

end
