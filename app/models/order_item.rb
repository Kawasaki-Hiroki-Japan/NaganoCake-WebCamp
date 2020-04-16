class OrderItem < ApplicationRecord
  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :price, presence: true, numericality: :only_integer
  validates :amount, presence: true, numericality: :only_integer
  validates :status, presence: true

  belongs_to :order
  belongs_to :item

  enum status: {
      "Cannot start": 0,
      "Awaiting production": 1,
      "In production": 2,
      "Production completed": 3
    }
end
