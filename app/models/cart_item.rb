class CartItem < ApplicationRecord
  validates :end_user_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true, numericality: :only_integer

  belongs_to :end_user
  belongs_to :item
end
